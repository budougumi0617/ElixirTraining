defmodule OtpApplications3.Server do
  use GenServer
  require Logger

  @vsn "1"
  defmodule State do
    defstruct current_number: 0, stash_pid: nil, delta: 1
  end

  ###
  # 外部API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end
  def next_number do
    with number = GenServer.call(__MODULE__, :next_number),
    do: "The next number is #{number}"
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
    values = OtpApplications3.Stash.get_value stash_pid
    { :ok,
      %State{current_number: values[:current_number], stash_pid: stash_pid, delta: values[:delta]} }
  end
  def handle_call(:next_number, _from, state) do
    { :reply, state.current_number, %{ state  | current_number: state.current_number + state.delta }}
  end
  def handle_cast({:increment_number, delta}, state) do
    { :noreply,
      # Update elements in Map. https://hexdocs.pm/elixir/Map.html
     %{state | current_number: state.current_number + delta, delta: delta}}
  end
  def terminate(reason, state) do
    OtpApplications3.Stash.save_value state.stash_pid, [current_number: state.current_number, delta: state.delta]
    IO.puts "reason : #{inspect reason}"
  end

  def code_change("0", old_state = { current_number, stash_pid }, _extra) do
    new_state = %State{current_number: current_number,
      stash_pid: stash_pid,
      delta: 1
    }
    Logger.info "Changing code from 0 to 1"
    {:ok, new_state}
  end
end

