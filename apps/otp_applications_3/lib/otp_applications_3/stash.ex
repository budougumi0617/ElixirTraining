defmodule OtpApplications3.Stash do
  use GenServer

  ###
  ## 外部API

  def start_link(values) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, values)
  end

  def save_value(pid, values) do
    GenServer.cast pid, {:save_value, values}
  end

  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  ###
  # GenServerの実装

  def handle_call(:get_value, _from, values) do
    { :reply, values, values}
  end

  def handle_cast({:save_value, values}, _current_value) do
    { :noreply, values }
  end
end
