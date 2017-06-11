defmodule MyString06Test do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "Capitalize senetences" do
    fun = fn -> 
      MyStrings06.capitalize_sentences("oh. a DOG. woof. ")
    end
    assert capture_io(fun) == "Oh. A dog. Woof. "
  end


end
