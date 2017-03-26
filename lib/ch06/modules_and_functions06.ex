defmodule Chop do
    def guess(actual, range) do
        _..max = range
        case actual do
            e when e == actual -> e
            _ -> _guess(actual, range, div(max, 2))
        end
    end

    def _guess(actual, range, estimate \\ 0) 

    def _guess(actual, range, estimate) when is_list(range) do
        min..max = range
        IO.puts "Is it #{estimate}"
        case div(max, 2) do
            e when e == actual -> e
            e when actual < e -> _guess(actual, min..e, e)
            e when e < actual -> _guess(actual, e..max, e)
        end
    end
end
