defmodule MyList03 do
    @z 122
    @charnumber 26
    def caesar([head | []], n) when head + n < @z, do: [head + n]
    def caesar([head | []], n), do: [head + rem(n, @z) - @charnumber]
    def caesar([head | tail], n) when head + n < @z, do: [head + n | caesar(tail, n)]
    def caesar([head | tail], n),  do: [head + rem(n, @z) - @charnumber| caesar(tail, n)]
end