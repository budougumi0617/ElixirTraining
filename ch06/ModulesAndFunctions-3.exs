defmodule Times do
    def double(n), do: n * 2
    def triple(n), do: n * 3
    def quadruple(n), do: Times.double(Times.double(n))
end

IO.puts Times.quadruple(3)

# [Running] elixir "/Users/budougumi0617/go/src/github.com/budougumi0617/ElixirTraining/ch06/ModulesAndFunctions-3.exs"
# 12