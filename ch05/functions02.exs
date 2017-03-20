fizzbuzz = fn
    0, 0, _ -> "FizzBuzz"
    0, _, _ -> "Fizz"
    _, 0, _ -> "Buzz"
    _, _, i -> i
end

IO.puts fizzbuzz.(0,1,13)
IO.puts fizzbuzz.(1,0,13)
IO.puts fizzbuzz.(0,0,13)
