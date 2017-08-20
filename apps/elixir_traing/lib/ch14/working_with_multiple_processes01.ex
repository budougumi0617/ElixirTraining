defmodule Chain do
    def counter(next_pid) do
        receive do
            n ->
              send next_pid, n+1
        end
    end

    def create_processes(n) do
        last = Enum.reduce 1..n, self(),
        fn (_, send_to) ->
            spawn(Chain, :counter, [send_to])
        end

        send last, 0

        receive do
            final_answer when is_integer (final_answer) ->
                "Result is #{inspect(final_answer)}"
        end
    end

    def run(n) do
        IO.puts inspect :timer.tc(Chain, :create_processes, [n])
    end
end

"""
MBP 2016 Core i5 3.1GHz, 16GB RAM
{3348, "Result is 10"}
{3886, "Result is 100"}
{11937, "Result is 1000"}
{95558, "Result is 10000"}
{3022338, "Result is 400000"}
{7309047, "Result is 1000000"}
"""
