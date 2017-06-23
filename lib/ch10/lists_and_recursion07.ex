defmodule MyList07 do
    def span(from, to) when from <= to, do: [from | span(from+1, to)]
    def span(_,_), do: []
    
    def prime(n) do
        for n <- span(2, n), prime?(n), do: n
    end

    defp prime?(n) when n < 2, do: false
    defp prime?(n) when n == 2, do: true
    defp prime?(n) when rem(n, 2) == 0, do: false
    defp prime?(n) do
        list = makeList(n-1, [])
        prime?(n, list)
    end

    defp prime?(n, [head | tail]) do
        if rem(n, head) == 0 do
            false
        else
            prime?(n, tail)
        end
    end
    defp prime?(_, []) do
        true 
    end
    defp makeList(num, list) do
        if num <= 2 do
            list
        else
            makeList(num-1, [num | list])
        end
    end
end
