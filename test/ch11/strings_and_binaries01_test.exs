defmodule MyString01Test do
  use ExUnit.Case

  test "Return true if printable" do

  assert MyStrings01.printable('foo') == true
  assert MyStrings01.printable(['cat' | 94]) == false  
  assert MyStrings01.printable(['cat' | 0]) == false  
  end

end
