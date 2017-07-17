defmodule MyList01 do
    def mapsum([], _), do: 0
    def mapsum([head | tail], f), do: f.(head) + mapsum(tail, f)
end