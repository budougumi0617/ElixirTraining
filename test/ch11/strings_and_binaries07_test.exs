defmodule MyString07Test do
  use ExUnit.Case
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
  test "Add total amount" do

    tax_rates = [ NC: 0.075, TX: 0.08]
    after_tax = [
      [ id: 123, ship_to: :NC, net_amount: 100.0, total_amount: 107.5 ],
      [ id: 124, ship_to: :OK, net_amount: 35.5, total_amount: 35.5 ],
      [ id: 125, ship_to: :TX, net_amount: 24.0, total_amount: 25.92 ],
      [ id: 126, ship_to: :TX, net_amount: 44.8, total_amount: 48.384 ],
      [ id: 127, ship_to: :NC, net_amount: 25.0, total_amount: 26.875 ],
      [ id: 128, ship_to: :MA, net_amount: 10.0, total_amount: 10.0 ],
      [ id: 129, ship_to: :CA, net_amount: 102.0, total_amount: 102.0 ],
      [ id: 120, ship_to: :NC, net_amount: 50.0, total_amount:  53.75 ]
    ]
    assert MyStrings07.parse("data_to_sab07.csv") |> calc tax_rates == after_tax
  end


end
