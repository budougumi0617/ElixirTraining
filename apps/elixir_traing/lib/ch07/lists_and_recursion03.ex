defmodule MyList03 do
    @z 122
    @a 96
    def caesar([], _ ), do: []
    def caesar([head | tail], n) when head + rem(n, @z) <= @z, do: [head + rem(n, @z) | caesar(tail, n)]
    def caesar([head | tail], n),  do: [rem(head + rem(n, @z), @z) + @a| caesar(tail, n)]
end