defmodule MyList03 do
    def caesar([head | []], n) when head + n < 122, do: [head + n]
    def caesar([head | []], n), do: [head + rem(n, 122) - 26]
    def caesar([head | tail], n) when head + n < 122, do: [head + n | caesar(tail, n)]
    def caesar([head | tail], n),  do: [head + rem(n, 122) - 26| caesar(tail, n)]
end