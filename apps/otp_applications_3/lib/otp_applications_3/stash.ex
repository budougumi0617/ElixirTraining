defmodule OtpApplications3.Stash do
  use GenServer
  require Logger

  @vsn "1"
  ###
  ## 外部API

  def start_link({current_number, delta}) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, {current_number, delta})
  end

  def save_value(pid, {current_number, delta}) do
    GenServer.cast pid, {:save_value, {current_number, delta}}
  end

  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  ###
  # GenServerの実装

  def handle_call(:get_value, _from, current_value) do
    { :reply, current_value, current_value}
  end

  def handle_cast({:save_value, {current_number, delta}}, _current_value) do
    { :noreply, {current_number, delta}}
  end

  def code_change("0", old_value = current_number, _extra) do
    new_value = {current_number, 1}
    Logger.info "Changing code from 0 to 1"
    {:ok, new_value}
  end
end
