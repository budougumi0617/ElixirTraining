defmodule LMBAU01Tracer do
  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  defmacro def(definition={name, _, args}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "==> call:   #{LMBAU01Tracer.dump_defn(unquote(name), unquote(args))}"
        result = unquote(content)
        IO.puts "<== result: #{result}" # quote内で宣言されているから、unquoteする必要がない？
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


defmodule LMBAU01Test do
  use LMBAU01Tracer

  def puts_sum_three(a, b, c), do: IO.inspect(a+b+c)
  def add_list(list),          do: Enum.reduce(list, 0, &(&1+&2))
end

LMBAU01Test.puts_sum_three(1,2,3)
LMBAU01Test.add_list([5,6,7,8])

# Result
#
# iex lib/ch21/tracer.ex
# Erlang/OTP 20 [erts-9.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
#
# ==> call:   puts_sum_three(1, 2, 3)
# 6
# <== result: 6
# ==> call:   add_list([5, 6, 7, 8])
# <== result: 26
# Interactive Elixir (1.5.1) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)>
