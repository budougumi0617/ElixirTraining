defmodule MyList02Test do
  use ExUnit.Case

  test "Get max value" do
    assert MyList02.max([1,2,3,4,3]) == 4
    assert MyList02.max([1,2,30,4,3]) == 30
    assert MyList02.max([1000,30,40,320]) == 1000
    assert MyList02.max([-1, -2, -5, -3]) == -1
  end

end
