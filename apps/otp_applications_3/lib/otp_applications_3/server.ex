defmodule OtpApplications3.Server do
  use GenServer

  @vsn "0"

  ###
  # 外部API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end
  def next_number do
    GenServer.call __MODULE__, :next_number
  end
  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end
  def arbitary_abort do
    exit(2)
  end

  ###
  # GenServerの実装

  def init(stash_pid) do
    current_number = OtpApplications3.Stash.get_value stash_pid
    { :ok, {current_number, stash_pid} }
  end
 def handle_call(:next_number, _from, {current_number, stash_pid}) do
    { :reply, current_number, {current_number+1, stash_pid} }
  end
  def handle_cast({:increment_number, delta}, {current_number, stash_pid}) do
    { :noreply, {current_number + delta, stash_pid} }
  end
  def terminate(reason, {current_number, stash_pid}) do
    OtpServer.Stash.save_value stash_pid, current_number
    IO.puts "reason : #{inspect reason}"
  end
end

