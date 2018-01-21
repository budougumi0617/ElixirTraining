defmodule Protocols03 do
  # 各要素を射影した結果を表示する
  def each(c, fun) do
    Enumerable.reduce(c, {:cont, []}, fn(x, _acc) -> fun.(x); {:cont, x}  end )
    :ok
  end

  # 各要素に対してフィルターをかけた結果のコレクションを返す
  def filter(c, fun) do
    filter_helper = fn element, acc ->
      is_true = fun.(element)
      if is_true do
        {:cont, [element | acc]}
      else
        {:cont, acc}
      end
    end
    {_, result} = Enumerable.reduce(c, {:cont, []}, filter_helper)
    Enum.reverse result
  end

  # 各要素を射影したコレクションを返す。
  def map(c, fun) do
    {_, result} = Enumerable.reduce(c, {:cont, []}, fn(x, acc) -> {:cont, [fun.(x) | acc]} end)
    Enum.reverse result
  end
end

IO.inspect "test"

# Result
# iex(1)> Protocols03.each([1,2,3], &IO.inspect(&1))
# 1
# 2
# 3
# :ok
# iex(2)> IO.inspect Protocols03.map([1,2,3], &(&1 * &1))
# [1, 4, 9]
# iex(3)> IO.inspect Protocols03.filter([1,2,3,4,5], &(&1 >= 4))
# [4, 5]
# [4, 5]