defmodule WorkingWithMultipleProcesses05 do
  import :timer, only: [ sleep: 1 ]

  # 親プロセスにメッセージ送信後、即終了する。
  def echo_and_exit(pid) do
    send pid, "from sub process."
    exit(:boom)
  end

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
    spawn_monitor(WorkingWithMultipleProcesses05, :echo_and_exit, [self()])
    sleep 500
    receiver()

    spawn_monitor(WorkingWithMultipleProcesses05, :echo_and_raise, [self()])
    sleep 500
    receiver()
  end
end


WorkingWithMultipleProcesses05.run()

# Result
# プロセスの起動方法をspawn_monitorに変更したので、:DOWNとReferenceを受け取るようになった。
# ╰─ elixir -r apps/elixir_traing/lib/ch14/working_with_multiple_processes05.ex
# MESSAGE RECEIVED: "from sub process."
# MESSAGE RECEIVED: {:DOWN, #Reference<0.0.4.7>, :process, #PID<0.76.0>, :boom}
# Nothing happened.

# 17:48:51.680 [error] Process #PID<0.77.0> raised an exception
# ** (RuntimeError) Raise in sub process
#     apps/elixir_traing/lib/ch14/working_with_multiple_processes05.ex:13: WorkingWithMultipleProcesses05.echo_and_raise/1
# MESSAGE RECEIVED: "from sub process."
# MESSAGE RECEIVED: {:DOWN, #Reference<0.0.4.21>, :process, #PID<0.77.0>, {%RuntimeError{message: "Raise in sub process"}, [{WorkingWithMultipleProcesses05, :echo_and_raise, 1, [file: 'apps/elixir_traing/lib/ch14/working_with_multiple_processes05.ex', line: 13]}]}}
# Nothing happened.

