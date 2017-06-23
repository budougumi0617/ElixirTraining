defmodule MyString04Test do
  use ExUnit.Case

  test "Operation +" do
    assert MyStrings04.calculate('10 + 0') == 10
  end
end
