defmodule WorkingWithMultipleProcesses04 do
  import :timer, only: [ sleep: 1 ]

  # 親プロセスにメッセージ送信後、例外を発生させる。
  def echo_and_raise(pid) do
    send pid, "from sub process."
    raise "Raise in sub process"
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
    spawn_link(WorkingWithMultipleProcesses04, :echo_and_raise, [self()])
    sleep 500
    receiver()
  end
end


WorkingWithMultipleProcesses04.run()

# Result
# 受信されているかに限らず、メッセージはスタックされている。例外もスタックされている。
# $ elixir -r apps/elixir_traing/lib/ch14/working_with_multiple_processes04.ex
#
# 17:44:08.590 [error] Process #PID<0.76.0> raised an exception
# ** (RuntimeError) Raise in sub process
#     apps/elixir_traing/lib/ch14/working_with_multiple_processes04.ex:7: WorkingWithMultipleProcesses04.echo_and_raise/1
# MESSAGE RECEIVED: "from sub process."
# MESSAGE RECEIVED: {:EXIT, #PID<0.76.0>, {%RuntimeError{message: "Raise in sub process"}, [{WorkingWithMultipleProcesses04, :echo_and_raise, 1, [file: 'apps/elixir_traing/lib/ch14/working_with_multiple_processes04.ex', line: 7]}]}}
# Nothing happened.

