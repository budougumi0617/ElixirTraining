defmodule FileSeeker do
  def count(scheduler) do
    send scheduler, { :ready, self()}
    receive do
      { :seek, dir, client } ->
        send client, { :answer, dir, count_seek(dir), self() }
        fib(scheduler)

      { :shutdown } ->
        exit(:normal)
    end
  end

  defp count_seek(dir) do
    File.ls!(".")
    |> Enum.map(fn(f) -> File.read!(f) end)
    |> Enum.map(fn body -> String.split(body) end) # ファイル内容文字列から単語に分割したリストを生成
    # catをカウントしないと。
  end
end

defmodule Scheduler do
  
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      { :ready, pid } when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, { :fib, next, self()}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [ {number, result} | results])
    end
  end
end

to_processes = [ 37, 37, 37, 37, 37, 37 ]

Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run,
    [num_processes, FibSolver, :fib, to_processes]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #    time(s)"
  end
  :io.format "~2B      ~.2f~n", [num_processes, time/1000000.0]
end

# Execute on 3.1 GHz Intel Core i5
# elixir working_with_multiple_processes08.exs
# [{37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}]

#  #    time(s)
#  1      6.23
#  2      3.16
#  3      2.98
#  4      3.12
#  5      3.20
#  6      2.93
#  7      3.03
#  8      2.95
#  9      2.89
# 10      2.91