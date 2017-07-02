defmodule MyStrings07 do
    def parse(file_name) do
        [_ | lines] = Enum.to_list(File.stream!(file_name, [:read], :line))
        Enum.map(lines, fn(line) ->
            row = String.split(line, ",")
            [set_id(Enum.at(row, 0)), 
             set_ship_to(Enum.at(row, 1)),
             set_net_amount Enum.at(row, 2)]
        end)
    end

    def set_id(s) do
        {n, _} = Integer.parse s
        {:id, n}
    end
    def set_ship_to(s) do
        {:ship_to, String.to_atom(String.trim(s, ":"))}
    end
    def set_net_amount(s) do
        {f, _} = Float.parse s
        {:net_amount, f}
    end
end