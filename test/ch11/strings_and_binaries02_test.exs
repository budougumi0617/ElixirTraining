defmodule MyString02Test do
  use ExUnit.Case

  test "Strings are anagram." do

  assert MyStrings02.anagram?('test', 'stte') == true
  assert MyStrings02.anagram?('test', 'foo') == false
  assert MyStrings02.anagram?('test', 'tttest') == false
  end

end
