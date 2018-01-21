defmodule MoreCoolStuff02 do
    def sigil_v(lines, _opt) do
        replace_helper = fn line ->
            list = String.split(line, ",")
            Enum.map list, &(replace(&1))
        end
        lines 
        |> String.trim_trailing
        |> String.split("\n")
        |> Enum.map(replace_helper)
    end

    def replace(x) do
        f = Float.parse x
        if f == :error do
            x
        else
            elem(f, 0)
        end
    end

    def example do
        ~v"""
        1,2,3
        cat, dog
        """
    end
end

IO.inspect MoreCoolStuff02.example

# $ iex more_cool_stuff02.ex
# Erlang/OTP 20 [erts-9.1.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

# [[1.0, 2.0, 3.0], ["cat", " dog"]]
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)