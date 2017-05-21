defmodule MyList07Test do
  use ExUnit.Case

  test "Show Prime" do
    assert MyList07.prime(10) == [2, 3, 5, 7]
    assert MyList07.prime(50) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
  end

end
