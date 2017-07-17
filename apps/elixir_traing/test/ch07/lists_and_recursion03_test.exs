defmodule MyList03Test do
  use ExUnit.Case

  test "Noused accumulator" do
    assert MyList03.caesar('ryvkve', 13) == 'elixir'
    assert MyList03.caesar('abz', 3) == 'dec'
    assert MyList03.caesar('abc', 122) == 'abc'
    assert MyList03.caesar('abz', 125) == 'dec'
    assert MyList03.caesar('z', 122) == 'z'
  end

end
