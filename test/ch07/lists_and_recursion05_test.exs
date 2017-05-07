defmodule MyList05Test do
  use ExUnit.Case

  test "My Enum" do
    list = [1,2,3,4]
    assert MyList05.all?(list, &(&1 < 4)) == Enum.all?(list, &(&1 < 4))
    assert MyList05.each(list, fn x -> x + 1 end) == Enum.each(list, fn x -> x + 1 end)
    assert MyList05.filter(list, fn(x) -> x==3 end) == Enum.filter(list, fn(x) -> x==3 end)
    assert MyList05.split(list, 3) == Enum.split(list, 3)
    assert MyList05.take(list, 3) == Enum.take(list, 3)
  end

end
