defmodule OtpApplications3.ServetTest do
  use ExUnit.Case

  test "pop" do
    OtpApplications3.Application.start(nil, nil)
    456 == OtpApplications3.Server.next_number
  end
end
