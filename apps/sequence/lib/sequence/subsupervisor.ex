defmodule OtpServer.SubSupervisor do
  user GenServer

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

  # W.I.P.
end
