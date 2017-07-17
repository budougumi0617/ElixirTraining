defmodule MyString05Test do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "Return true if printable" do
    fun = fn -> 
      MyStrings05.center(["cat", "zebra", "elephant"])
    end
    assert capture_io(fun) == """
      cat
     zebra
    elephant
    """
  end

  test "Get max length" do
    assert MyStrings05.max_length(["cat","elephant", "zebra"]) == 8
  end

end
