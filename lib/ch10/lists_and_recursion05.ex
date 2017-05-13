defmodule MyList05 do
    def all?([head | tail], f), do: f.(head) && all?(tail, f)
    def each([head | tail], f) do 
        f.(head)
        each(tail, f)
    end
    def each(_, _) do
        :ok
    end
    def filter([head | tail], f) do
        if f.(head) do
            _filter(tail, f, [head])
        else
            filter(tail, f)
        end
    end
    defp _filter([head | tail], f, list) do
        if f.(head) do
            _filter(tail, f, [list, head])
        else
            IO.inspect list
            _filter(tail, f, list)
        end
    end
    defp _filter([], _, list) do
        list
    end
    def split([head | tail], i) do
        _split([head], tail, i-1)
    end
    defp _split(f, s, 0) do
        {f, s}
    end
    defp _split(f, [head| tail], i) do
        _split(f ++ [head], tail, i-1)
    end

    def take([head | tail], i) do
        _take([head], tail, i-1)
    end
    def take(_, 0) do
        []
    end
    defp _take(ans, _, 0) do
        ans
    end
    defp _take(ans, [head | tail], i) do
        _take(ans ++ [head], tail, i-1)
    end
end