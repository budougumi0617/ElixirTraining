defmodule MyStrings06 do
    def capitalize_sentences(s) do
        words = String.split(s, ". ")
        puts(words)
    end
    def puts(["" | _]), do: []
    def puts([head | tail]) do
        IO.write String.capitalize(head) <> ". "
        puts(tail)
    end
    def puts(_) do
        []
    end
end