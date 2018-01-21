defmodule MoreCoolStuff01 do
    def sigil_v(lines, _opt) do
        lines 
        |> String.trim_trailing
        |> String.split("\n")
        |> Enum.map(fn line -> String.split(line, ",") end)
    end

    def example do
        ~v"""
        1,2,3
        4,5,6
        7,8,9
        """
    end
end

IO.inspect MoreCoolStuff01.example

# $ iex more_cool_stuff01.ex
# Erlang/OTP 20 [erts-9.1.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

# [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)>