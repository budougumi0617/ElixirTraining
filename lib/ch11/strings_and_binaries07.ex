defmodule MyStrings07 do
    def parse(file_name) do
        file = File.open! file_name, [:read]
        f = IO.read(file, :line)
        # if "id,ship_to,net_amount\n" == f do
                
        # end
    end
end