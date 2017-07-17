fizzbuzz = fn
    0, 0, _ -> "FizzBuzz"
    0, _, _ -> "Fizz"
    _, 0, _ -> "Buzz"
    _, _, i -> i
end

recuirsive_fizzbuzz = fn
  n -> fizzbuzz.(rem(n,3), rem(n,5), n)
end

IO.puts recuirsive_fizzbuzz.(10)
IO.puts recuirsive_fizzbuzz.(11)
IO.puts recuirsive_fizzbuzz.(12)
IO.puts recuirsive_fizzbuzz.(13)
IO.puts recuirsive_fizzbuzz.(14)
IO.puts recuirsive_fizzbuzz.(15)
IO.puts recuirsive_fizzbuzz.(16)
