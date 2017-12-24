defmodule LMBAU02Tracer do
  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  defmacro def(definition={name, _, args}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts IO.ANSI.format([:red, "==> call:   #{LMBAU02Tracer.dump_defn(unquote(name), unquote(args))}"])
        result = unquote(content)
        IO.puts IO.ANSI.format([:red, "<== result: #{result}"])
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end
end


defmodule LMBAU02Test do
  use LMBAU02Tracer

  def puts_sum_three(a, b, c), do: IO.inspect(a+b+c)
  def add_list(list),          do: Enum.reduce(list, 0, &(&1+&2))
end

LMBAU01Test.puts_sum_three(1,2,3)
LMBAU01Test.add_list([5,6,7,8])

# https://hexdocs.pm/elixir/IO.ANSI.html
# https://en.wikipedia.org/wiki/ANSI_escape_code
# iex(5)> IO.ANSI.format(["hello, ", :inverse, :bright, "world!"], true)
# [[[[[[], "hello, "] | "\e[7m"] | "\e[1m"], "world!"] | "\e[0m"]
# iex(7)> IO.ANSI.format(["hello, ", :inverse, "world!"], true)
# [[[[[], "hello, "] | "\e[7m"], "world!"] | "\e[0m"]
