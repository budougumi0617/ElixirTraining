defmodule MyStrings01 do
    def printable([head | _]) when  head < 96 when  126 < head, do: false
    def printable([_ | tail]), do: printable(tail)
    def printable(_), do: true
end