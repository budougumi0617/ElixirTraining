defmodule Push.OtpServer02 do
  use GenServer

  def handle_call(:pop, _from, current_stack) do
    [ head | tail ] = current_stack
    { :reply, head, tail }
  end

  # 返事を必要としないのでhandle_cast
  # 戻り値は:noreplyと新しい状態のみ。
  def handle_cast({:push, e}, current_stack) do # 戻さないのでクライアントのPID(from)もいらない。
    { :noreply, [ e | current_stack ]}
  end
end


# $ iex -S mix
# iex(2)> { :ok, pid }=  GenServer.start_link(Push.OtpServer02, [5, "cat", 9])
# {:ok, #PID<0.169.0>}
# iex(3)> GenServer.cast(pid, {:push, 10})
# :ok
# iex(4)> GenServer.call(pid, :pop)
# 10
# iex(5)> GenServer.call(pid, :pop)
# 5
# iex(6)>

