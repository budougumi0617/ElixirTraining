defmodule Chop do
    def guess(actual, min..max) do
        e = div(min + max, 2)
        IO.puts "Is it #{e}"
        _guess(actual, min..max, e)
    end

    def _guess(actual, _, estimate) when actual == estimate do
        estimate
    end

    def _guess(actual, min.._, estimate) when actual < estimate do
        guess(actual, min..estimate-1)
    end

    def _guess(actual, _..max, estimate) when estimate < actual do
        guess(actual, estimate+1..max)
    end
end
