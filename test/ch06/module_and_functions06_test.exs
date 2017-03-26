defmodule ChopTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "Guess is like a Divide And Conquer" do
    fun = fn ->
      assert Chop.guess(273, 1..1000) == 273
    end
    assert capture_io(fun) == "Is it 500
Is it 250
Is it 375
Is it 312
Is it 281
Is it 265
Is it 273"
    # tip: or use only: "capture_io(fun)" to silence the IO output (so only assert the return value)
  end
end
