defmodule MyList02 do
    def max([head|tail]), do: _max(tail, head)

    defp _max([], maximum), do: maximum
    defp _max([head|tail], value) when head >= value, do: _max(tail, head)
    defp _max([_head|tail], value), do: _max(tail, value)
    defp _max(v1, v2) when v1 >= v2, do: v1
    defp _max(_v1, v2), do: v2
end