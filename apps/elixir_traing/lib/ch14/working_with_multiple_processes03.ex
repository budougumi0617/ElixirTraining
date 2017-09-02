defmodule WorkingWithMultipleProcesses03 do
  import :timer, only: [ sleep: 1 ]

  # 親プロセスにメッセージ送信後、即終了する。
  def echo_and_exit(pid) do
    send pid, "from sub process."
    exit(:boom)
  end

  # メッセージを再帰的に受信する。1秒間未受信だった場合は終了する。
  def receiver do
    receive do
      msg -> IO.puts "MESSAGE RECEIVED: #{inspect(msg)}"
      receiver()
    after 1000 ->
      IO.puts "Nothing happened."
    end
  end

  def run do
    # リンクしたプロセスからの終了シグナルを処理可能なメッセージに変換する
    Process.flag(:trap_exit, true)
    spawn_link(WorkingWithMultipleProcesses03, :echo_and_exit, [self()])
    sleep 500
    receiver()
  end
end


WorkingWithMultipleProcesses03.run()

# Result
# 受信されているかに限らず、メッセージはスタックされている。
# $ elixir -r apps/elixir_traing/lib/ch14/working_with_multiple_processes03.ex
# MESSAGE RECEIVED: "from sub process."
# MESSAGE RECEIVED: {:EXIT, #PID<0.76.0>, :boom}
# Nothing happened.

