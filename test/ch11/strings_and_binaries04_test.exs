defmodule MyString04Test do
  use ExUnit.Case

  test "Operation +" do
    assert MyStrings04.calculate('10 + 0') == 10
  end

  test "Operation -" do
    assert MyStrings04.calculate('10 - 5') == 5
  end

  test "Operation *" do
    assert MyStrings04.calculate('10 * 5') == 50
  end
  
  test "Operation /" do
    assert MyStrings04.calculate('9 / 3') == 3
  end
end
