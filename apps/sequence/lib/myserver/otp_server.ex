defmodule OtpServer.OtpServer do
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
    if e == 'err' do
      IO.puts 'got err'
      System.halt 0
    end
   { :noreply, [ e | current_stack ]}
  end

  def terminate(state, reason) do
    IO.puts "state : #{inspect state}"
    IO.puts "reason : #{inspect reason}"
  end
end

# $ iex -S mix
# iex -S mix
# Erlang/OTP 20 [erts-9.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
#
# Interactive Elixir (1.5.1) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> OtpServer.OtpServer.
# pop/0           push/1          start_link/1
# iex(1)> OtpServer.OtpServer.pop
# 123

