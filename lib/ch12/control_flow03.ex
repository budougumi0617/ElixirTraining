defmodule MyControl03 do
    def ok!({:ok, data}), do: data
    def ok!(args) do
        str = Kernel.inspect args
        raise ArgumentError, message: "Invalid #{str}"
    end
end