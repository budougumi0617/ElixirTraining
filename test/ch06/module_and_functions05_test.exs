defmodule Recursive2Test do
  use ExUnit.Case

  test "Sum numbers" do
    assert Recursive2.gcd(3, 0) == 3
    assert Recursive2.gcd(10, 5) == 5
    assert Recursive2.gcd(24, 8) == 8
  end
  
  
end
