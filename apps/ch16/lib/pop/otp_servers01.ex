defmodule Pop.OtpServer01 do
  use GenServer

  def handle_call(:pop, _from, current_stack) do
    [ head | tail ] = current_stack
    { :reply, head, tail }
  end
end


# $ iex -S mix
#Erlang/OTP 19 [erts-8.2.2] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
#Generated ch16 app
#Interactive Elixir (1.4.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> { :ok, pid }=  GenServer.start_link(Pop.OtpServer01, [5, "cat", 9])
# {:ok, #PID<0.151.0>}
# iex(2)> GenServer.call(pid, :pop)
# 5
# iex(3)> GenServer.call(pid, :pop)
# "cat"
# iex(4)> GenServer.call(pid, :pop)
# 9

