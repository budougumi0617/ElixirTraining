defmodule WorkingWithMultipleProcesses2 do
    def greet do
        receive do
            {sender, msg} ->
                send sender, { :ok, "Hello #{msg}."}
            greet()
        end
    end
end

pid1 = spawn(WorkingWithMultipleProcesses2, :greet, [])
pid2 = spawn(WorkingWithMultipleProcesses2, :greet, [])

send pid1, {self(), "pid1_1"}
send pid1, {self(), "pid1_2"}
send pid1, {self(), "pid1_3"}
send pid2, {self(), "pid2_1"}
send pid2, {self(), "pid2_2"}
send pid2, {self(), "pid2_3"}

receive do
    {:ok, msg} -> IO.puts msg
end

receive do
    {:ok, msg} -> IO.puts msg
end
