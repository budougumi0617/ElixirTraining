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
