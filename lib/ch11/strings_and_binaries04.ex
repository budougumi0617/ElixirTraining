defmodule MyStrings04 do
    def calculate(fomula) do
        # Get first number
        {n1, fomula} = number(fomula)

        # Get operator
        fomula = trim(fomula)
        [op | fomula] = fomula
        fomula = trim(fomula)

        # Get second number
        {n2, _} = number(fomula)

        operate(n1, op, n2)
    end

    #  Return number and remaining characters
    def number(str), do: _number_digits(str, 0)

    defp _number_digits([], value), do: {value, []}
    defp _number_digits([ digit | tail ], value)
    when digit in '1234567890' do
        _number_digits(tail, value*10 + digit - ?0)
    end
    defp _number_digits(str, value) do
        {value, str}
    end

    # Remove head spaces
    def trim([?\s | str]), do: trim(str)
    def trim(str), do: str

    # Calculate fomula
    def operate(n1, ?+, n2), do: n1 + n2
    def operate(n1, ?-, n2), do: n1 - n2
    def operate(n1, ?*, n2), do: n1 * n2
    def operate(n1, ?/, n2), do: n1 / n2
end
