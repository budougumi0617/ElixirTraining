defmodule MyList02 do
    def max([head|tail]), do: _max(tail, head)
    defp _max([], maximum) do
        maximum
    end
    defp _max([head|tail], value) when head >= value do
         _max(tail, head)
    end
    defp _max([head|tail], value) do
         _max(tail, value)
    end
    defp _max(v1, v2) when v1 >= v2 do
        v1
    end
    defp _max(v1, v2) do
        v2
    end
end