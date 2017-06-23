defmodule MyList04 do
    def span(from, to) when from <= to, do: [from | span(from+1, to)]
    def span(_, _), do: []
end