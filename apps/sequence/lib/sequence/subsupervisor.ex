defmodule OtpServer.SubSupervisor do
  use GenServer

  ###
  ## 外部API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end
  def pop do
    GenServer.call __MODULE__, :pop
  end
  def push(e) do
    GenServer.cast __MODULE__, {:push, e}
  end

  ###
  # GenServerの実装

  def init(stash_pid) do
    current_stack = OtpServer.Stash.get_value stash_pid
    { :ok, {pop, current_stack} }
  end
  def handle_call(:push, _from, {[head | tail], stash_pid }) do
    { :reply, head, {tail, stash_pid} }
  end
  def handle_cast({:push, e}, {current_stack, stash_pid}) do
    { :noreply, {[e | current_stack], stash_pid }}
  end
  def terminate(_reason, {current_stack, stash_pid }) do
    OtpServer.Stash.save_value stash_pid, current_stack
  end
end
