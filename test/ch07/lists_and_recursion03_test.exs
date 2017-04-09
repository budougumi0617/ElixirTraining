defmodule MyList03Test do
  use ExUnit.Case

  test "Noused accumulator" do
    assert MyList03.caesar('ryvkve', 13) == 'elixir'
  end

end
