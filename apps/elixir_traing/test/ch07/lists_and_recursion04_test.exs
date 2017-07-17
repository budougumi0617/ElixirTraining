defmodule MyList04Test do
  use ExUnit.Case

  test "list numbers" do
    assert MyList04.span(1, 5) == [1, 2, 3, 4, 5]
    assert MyList04.span(2, 2) == [2]
    assert MyList04.span(5, 0) == []
  end

end
