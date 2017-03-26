defmodule Times3Test do
  use ExUnit.Case

  test "Double integer." do
    assert Times3.double(3) == 6
    assert Times3.double(2) == 4
  end
  
  test "Triple integer." do
    assert Times3.triple(3) == 9
    assert Times3.triple(2) == 6
  end
  
  test "Quadruple integer." do
    assert Times3.quadruple(3) == 12
    assert Times3.quadruple(2) == 8
  end
end
