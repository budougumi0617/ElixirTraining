defmodule MyStrings02 do
    def anagram?(s1, s2), do: s1 -- s2 == [] and s2 -- s1 == []
end