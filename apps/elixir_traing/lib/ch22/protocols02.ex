defprotocol Protocols02 do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Protocols02, for: [BitString, List] do
  @z 122
  @a 96

  def encrypt(string, shift), do: string |> to_charlist |> Enum.map(&(shift_char(&1, shift))) |> List.to_string
  def rot13(string), do: encrypt(string, 13)

  def shift_char(c, shift) do
    cond do
      c + rem(shift, @z) <= @z -> c+ rem(shift, @z)
      true -> rem(c + rem(shift, @z), @z) + @a
    end
  end
end

defmodule SearchRot do
  @file_name "2of12.txt"
  # @file_name "words.txt"

  def searh_rot13() do
    words_set = @file_name
                |> File.stream!
                |> Stream.map(&String.trim(&1))
                |> MapSet.new

    Enum.flat_map(words_set, fn word -> 
      rot_word = Protocols02.rot13(word)
      # IO.inspect words_set
      # IO.inspect "#{word} -> #{rot_word}"
      case MapSet.member?(words_set, rot_word) do
        true ->  
        ["#{word} -> #{rot_word}"]
        false -> []
      end
    end)
  end

end

IO.inspect SearchRot.searh_rot13

# Result
# $ elixir protocols02.ex
# ["i -> v", "g -> t", "a -> n", "s -> f", "balk -> onyx", "n -> a", "m -> z",
#  "nowhere -> abjurer", "ah -> nu", "q -> d", "r -> e", "d -> q", "j -> w",
#  "p -> c", "fur -> she", "nu -> ah", "nun -> aha", "she -> fur", "ant -> nag",
#  "oho -> bub", "gel -> try", "onyx -> balk", "envy -> rail", "ova -> bin",
#  "x -> k", "v -> i", "o -> b", "t -> g", "z -> m", "sync -> flap", "l -> y",
#  "bar -> one", "b -> o", "k -> x", "e -> r", "f -> s", "y -> l", "h -> u",
#  "nag -> ant", "u -> h", "bub -> oho", "gnat -> tang", "try -> gel",
#  "crag -> pent", "be -> or", "tang -> gnat", "flap -> sync", "rail -> envy",
#  "pent -> crag", "abjurer -> nowhere", ...]

