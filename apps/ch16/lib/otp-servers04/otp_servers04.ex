defmodule OtpServer.OtpServer04 do
  use GenServer

  #####
  # External API

  def start_link(current_stack) do
    GenServer.start_link(__MODULE__, current_stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(elem) do
    GenServer.cast(__MODULE__, {:push, elem})
  end

  #####
  # Server implementations

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
# Erlang/OTP 20 [erts-9.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
#
# Compiling 1 file (.ex)
# Generated ch16 app
# Interactive Elixir (1.5.1) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> OtpServer.OtpServer04.start_link ["test", 10, 20]
# {:ok, #PID<0.131.0>}
# iex(2)> OtpServer.OtpServer04.pop
# "test"
# iex(3)> OtpServer.OtpServer04.push 200
# :ok
# iex(4)> OtpServer.OtpServer04.pop
# 200

