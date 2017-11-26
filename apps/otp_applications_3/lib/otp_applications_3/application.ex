defmodule OtpApplications3.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    OtpApplications3.Supervisor
      .start_link(Application.get_env(:otp_applications_3, :initial_number))
  end
end
