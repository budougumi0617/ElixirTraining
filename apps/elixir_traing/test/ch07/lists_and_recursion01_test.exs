defmodule MyList01Test do
  use ExUnit.Case

  test "Map and Sum" do
    assert MyList01.mapsum([1,2,3], &(&1 * &1)) == 14
  end

end
