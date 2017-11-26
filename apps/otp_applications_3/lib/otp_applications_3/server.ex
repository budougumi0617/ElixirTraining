defmodule OtpServer.Server do
  use GenServer

  ###
  # 外部API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end
  def pop do
    GenServer.call __MODULE__, :pop
  end
  def push(e) do
    GenServer.cast __MODULE__, {:push, e}
  end
  def arbitary_abort do
    exit(2)
  end

  ###
  # GenServerの実装

  def init(stash_pid) do
    current_stack = OtpServer.Stash.get_value stash_pid
    { :ok, {current_stack, stash_pid} }
  end
  def handle_call(:pop, _from, {[head | tail], stash_pid}) do
    { :reply, head, {tail, stash_pid} }
  end
  def handle_cast({:push, e}, {current_stack, stash_pid}) do
    { :noreply, {[e | current_stack], stash_pid} }
  end
  def terminate(reason, {current_stack, stash_pid}) do
    OtpServer.Stash.save_value stash_pid, current_stack
    IO.puts "reason : #{inspect reason}"
  end
end


# $ iex -S mix
# Erlang/OTP 20 [erts-9.1.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
#
# Compiling 1 file (.ex)
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> OtpServer.Server.arbitary_abort
# ** (exit) 2
#     (sequence) lib/sequence/server.ex:17: OtpServer.Server.arbitary_abort/0
# iex(1)> OtpServer.Server.pop
# "cat"
# iex(2)> OtpServer.Server.push 'test'
# :ok
# iex(3)> OtpServer.Server.arbitary_abort
# ** (exit) 2
#     (sequence) lib/sequence/server.ex:17: OtpServer.Server.arbitary_abort/0
# iex(3)> OtpServer.Server.pop
# 'test'