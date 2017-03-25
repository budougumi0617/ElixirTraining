defmodule Times3Test do
  use ExUnit.Case

  test "Double integer." do
    assert Times3.double(3) == 6
    assert Times3.double(2) == 4
  end

  test "Quadruple integer." do
    assert Times3.quadruple(3) == 12
    assert Times3.quadruple(2) == 8
  end
end
