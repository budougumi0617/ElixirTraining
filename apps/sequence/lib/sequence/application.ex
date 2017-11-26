defmodule OtpServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    {:ok, _pid} = OtpServer.Supervisor.start_link(["cat", 120, 30])
  end
end
