defmodule MyControl03Test do
  use ExUnit.Case
  
  test "No Raise Error" do
    data = MyControl03.ok! File.open("./test/ch12/control_flow03_test.exs")
    File.close(data)
  end

  test "Raise Error" do
    assert_raise ArgumentError, "Invalid {:error, :enoent}", fn ->
      MyControl03.ok! File.open("nofile")
    end
  end
end
