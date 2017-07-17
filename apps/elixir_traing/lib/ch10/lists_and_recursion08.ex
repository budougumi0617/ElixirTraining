defmodule MyList08 do
    def calc(rates, orders) do
        for order <- orders, do: order ++ [total_amount: total(rates, order)]
    end
    def total(rates, order) do
        if Keyword.has_key?(rates, order[:ship_to]) do
            order[:net_amount] * (1.00 + rates[order[:ship_to]])
        else
            order[:net_amount]
        end
    end
end
