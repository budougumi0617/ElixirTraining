defmodule MyList05 do
    def all?([head | tail], f), do: f.(head) && all?(tail, f)
    def each([head | tail], f) do 
        f.(head)
        each(tail, f)
    end
    def each([],f) do
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
    def split([head | tail], i), do: []
    def take(list, f), do: []
end