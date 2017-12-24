defprotocol Protocols01 do
  def encrypt(string, shift)
  def rotl13(string)
end

defimpl Protocols01, for: [BitString, List] do
  @z 122
  @a 96

  def encrypt(string, shift), do: string |> to_charlist |> Enum.map(&(shift_char(&1, shift)))
  def rotl13(string), do: encrypt(string, 13)

  def shift_char(c, shift) do
    cond do
      c + rem(shift, @z) <= @z -> c+ rem(shift, @z)
      true -> rem(c + rem(shift, @z), @z) + @a
    end
  end
end

IO.puts Protocols01.encrypt("test abcz", 1)

# Result
# iex lib/ch21/protocols01.ex
# Erlang/OTP 20 [erts-9.1.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
#
# uftu!bcda
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)>

# References
# apps/elixir_traing/lib/ch07/lists_and_recursion03.ex


