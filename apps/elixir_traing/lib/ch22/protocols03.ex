defmodule Protocols03 do
  def each(c, fun) do
    Enumerable.reduce(c, {:cont, []}, fn(x, _acc) -> fun.(x); {:cont, x}  end )
    :ok
  end

  def filter(collection, fun) do
    collection
    |> Enum.reduce([], fn(x, acc) -> if fun.(x), do: [x | acc], else: acc end)
    |> Enum.reverse
  end

  def map(collection, fun) do
    collection
    |> Enum.reduce([], fn(x, acc) -> [fun.(x) | acc] end)
    |> Enum.reverse
  end
end

IO.inspect "test"

# Result
# iex(1)> Protocols03.each([1,2,3], &IO.inspect(&1))
# 1
# 2
# 3
# :ok