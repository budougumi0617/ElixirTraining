defmodule Chop do
    def guess(actual, range) do
        min..max = range
        case max do
            e when e == actual -> e
            _ -> _guess(actual, range, div(min + max, 2))
        end
    end

    def _guess(actual, range, estimate \\ 0) 

    def _guess(actual, _, estimate) when actual == estimate do
        IO.puts "Is it #{estimate}"
        estimate
    end

    def _guess(actual, range, estimate) when actual < estimate do
        min..max = range
        IO.puts "Is it #{estimate}"
        _guess(actual, min..estimate-1, div(min + estimate-1, 2))
    end
    def _guess(actual, range, estimate) when estimate < actual do
        min..max = range
        IO.puts "Is it #{estimate}"
        _guess(actual, estimate+1..max, div(estimate+1 + max, 2))
    end
end
