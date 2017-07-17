defmodule Times1Test do
  use ExUnit.Case

  test "Double integer." do
    assert Times1.double(3) == 6
    assert Times1.double(2) == 4
  end

  test "Triple integer." do
    assert Times1.triple(3) == 9
    assert Times1.triple(2) == 6
  end
end
