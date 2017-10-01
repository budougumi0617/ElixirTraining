defmodule FileSeeker do
  def count(scheduler) do
    send scheduler, { :ready, self()}
    receive do
      { :count, file, client } ->
        send client, { :answer, file, count_word(file), self() }
        count(scheduler)

      { :shutdown } ->
        exit(:normal)
    end
  end


  defp count_word(filename) do
    File.read!(filename)
    |> String.split()
    |> Enum.filter(&(&1 == "do"))
    |> Enum.count(&(&1))
  end

  # ディレクトリに対して一連の処理。
  defp count_seek(dir) do
    File.ls!(dir)
    |> Enum.reject(&(File.dir?(&1)))
    |> Enum.map(&(File.read!(&1)))
    |> Enum.map(&(String.split(&1)))
    |> Enum.map(fn list -> Enum.filter(list, &(&1 == "do")) end) # 入れ子になるので外側の無名関数はは&1使えない
    |> Enum.map(&(Enum.count(&1)))
  end
  # Twitterで教えてもらったもっとスマートな回答。
  # for x <- File.ls!(dir), !File.dir?(x), do: File.read!(x) |> String.split() |> Enum.filter(&(&1 == "do")) |> Enum.count(&(&1))
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
        send pid, { :count, next, self()}
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

to_processes = File.ls!("./") |> Enum.reject(&(File.dir?(&1))) |> Enum.map(&(Path.expand(&1)))

Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run,
    [num_processes, FileSeeker, :count, to_processes]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #    time(s)"
  end
  :io.format "~2B      ~.2f~n", [num_processes, time/1000000.0]
end

# Execute on 3.1 GHz Intel Core i5
# catではなくて、'do'の数を算出している。
# elixir working_with_multiple_processes09.exs
# [{".working_with_multiple_processes09.exs.swp", 0}, {"working_with_multiple_processes01.ex", 6}, {"working_with_multiple_processes02.ex", 5}, {"working_with_multiple_processes03.ex", 5}, {"working_with_multiple_processes04.ex", 5}, {"working_with_multiple_processes05.ex", 6}, {"working_with_multiple_processes06.ex", 3}, {"working_with_multiple_processes07.ex", 5}, {"working_with_multiple_processes08.exs", 9}, {"working_with_multiple_processes09.exs", 11}]
#
#  #    time(s)
#  1      0.01
#  2      0.00
#  3      0.00
#  4      0.00
#  5      0.01
#  6      0.01
#  7      0.01
#  8      0.00
#  9      0.01
# 10      0.01

