defmodule MyList00Test do
  use ExUnit.Case

  test "Noused accumulator" do
    assert MyList00.sum([1,2,3,4]) == 10
  end

end
