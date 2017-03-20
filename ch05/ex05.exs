IO.puts "Problem"
IO.inspect Enum.map [1,2,3,4], fn x -> x + 2 end
IO.puts "Answer"
IO.inspect Enum.map [1,2,3,4], &(&1 + 2)

IO.puts "Problem"
Enum.each [1,2,3,4], fn x -> IO.inspect x end
IO.puts "Answer"
Enum.map [1,2,3,4], &(IO.inspect &1)

