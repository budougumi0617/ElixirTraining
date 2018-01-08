defprotocol Protocols02 do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Protocols02, for: [BitString, List] do
  @z 122
  @a 96

  def encrypt(string, shift), do: string |> to_charlist |> Enum.map(&(shift_char(&1, shift)))
  def rot13(string), do: encrypt(string, 13)

  def shift_char(c, shift) do
    cond do
      c + rem(shift, @z) <= @z -> c+ rem(shift, @z)
      true -> rem(c + rem(shift, @z), @z) + @a
    end
  end
end

defmodule SearchRot do
  @file_name "words.txt"

  def rotation_exists?(word, words) do
    rotated = Protocols02.rot13(word)
    MapSet.member?(words, rotated)
  end

  def filter_results(word, words, acc) do
    case rotation_exists?(word, words) do
      true -> [word | acc]
      false -> acc
    end
  end

  def searh_rot13() do
    words = @file_name
    |> File.stream!
    |> Stream.map(&String.trim(&1))
    |> MapSet.new

    words
    |> Enum.reduce([], fn(word, acc)-> filter_results(word, words, acc) end)
  end

end

IO.inspect SearchRot.searh_rot13

# Result
# iex lib/ch21/protocols01.ex
# Erlang/OTP 20 [erts-9.1.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
#
# uftu!bcda
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)>

# References
# apps/elixir_traing/lib/ch07/lists_and_recursion03.ex


