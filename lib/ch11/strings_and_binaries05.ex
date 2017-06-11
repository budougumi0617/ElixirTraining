defmodule MyStrings05 do
    def max_length(list, l \\ 0)
    def center(list) do
        c = max_length(list)
        puts(list, c)
    end

    def puts([], _), do: []

    def puts([head | tail], c) do
        spaces = div(c - String.length(head), 2)
        count = String.length(head) + spaces
        out = String.rjust(head, count)
        IO.puts(out)
        puts(tail, c)
    end
    
    def max_length([head|tail], l) do 
        c = String.length(head)
        case c do
             c when l < c -> max_length(tail, c)
            _ -> max_length(tail, l)
        end
    end
    def max_length([], l), do: l
end