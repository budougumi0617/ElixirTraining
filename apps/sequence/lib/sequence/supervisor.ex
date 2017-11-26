defmodule OtpServer.Supervisor do
  use Supervisor
  def start_link(initial_stack) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_stack])
    start_workers(sup, initial_stack)
    result
  end
  def start_workers(sup, initial_stack) do
    # スタッシュワーカーを開始
    {:ok, stash} =
      Supervisor.start_child(sup, worker(OtpServer.Stash, [initial_stack]))
    # そして実際の stack サーバのスーパーバイザを開始
    Supervisor.start_child(sup, supervisor(OtpServer.SubSupervisor, [stash]))
  end
  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
