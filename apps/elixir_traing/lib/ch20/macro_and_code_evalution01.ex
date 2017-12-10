defmodule MacroAndCodeEvalution01 do
  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(do_clause)
        _                         -> unquote(else_clause)
      end
    end
  end
end

defmodule UnlessTest do
  require MacroAndCodeEvalution01
  MacroAndCodeEvalution01.unless 1 != 2 do
    IO.puts "FALSE"
  else
    IO.puts "TRUE"
  end
end

# iex apps/elixir_traing/lib/ch17/macro_and_code_evalution01.ex
# Erlang/OTP 20 [erts-9.1.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
# 
# TRUE
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
