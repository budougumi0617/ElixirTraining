prefix = fn f -> (fn s -> "#{f} " <> s end) end
mrs = prefix.("Mrs")
IO.puts mrs.("Smith")
IO.puts prefix.("Elixir").("Rocks")
