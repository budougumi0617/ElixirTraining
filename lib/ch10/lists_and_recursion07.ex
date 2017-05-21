defmodule MyList07 do
    def span(from, to) when from <= to, do: [from | span(from+1, to)]
    def span(from, to), do: []
    
    def prime(n) do
        for n <- span(2, n), prime?(n), do: n
    end

    defp prime?(n) when n < 2, do: false
    defp prime?(n) when n == 2, do: true
    defp prime?(n) do
        list = Enum.to_list(3..n-1)
        Enum.any?(list, fn(x) -> rem(n, x) == 0 end)
    end
end