defmodule MacroAndCodeEvalution02 do
  defmacro times_n(number) do
    quote do
      def unquote(:"times_#{number}")(val) do
        val * unquote(number)
      end
    end
  end
end

defmodule TimesTest do
  require MacroAndCodeEvalution02
  MacroAndCodeEvalution02.times_n(3)
  MacroAndCodeEvalution02.times_n(4)
end

IO.puts TimesTest.times_3(4)
IO.puts TimesTest.times_4(5)


# iex ch20/macro_and_code_evalution02.ex
# Erlang/OTP 20 [erts-9.1.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
#
# 12
# 20
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
