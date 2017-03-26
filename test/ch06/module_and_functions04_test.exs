defmodule RecursiveTest do
  use ExUnit.Case

  test "Sum numbers" do
    assert Recursive.sum(3) == 6
    assert Recursive.sum(0) == 0
    assert Recursive.sum(5) == 15
  end
  
  
end
