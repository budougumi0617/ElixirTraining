defmodule Protocols04 do
    defimpl Inspect, for: Person do
      def inspect(p, _) do
          "%#{p.__struct__}{age: #{p.age}, name: #{p.name}}"
      end
    end
end


# 結果確認用のダミー構造体
defmodule Person do
  defstruct [:name, :age]
end


# iex(1)> p = %Person{age: 10, name: 'budougumi'}
# %Elixir.Person{age: 10, name: budougumi}
# iex(2)> p2 = p
# %Elixir.Person{age: 10, name: budougumi}
# iex(3)> p2 == p
# true
# iex(4)> p2 = IO.inspect p
# %Elixir.Person{age: 10, name: budougumi}
# %Elixir.Person{age: 10, name: budougumi}
# iex(5)> p2 == p
# true