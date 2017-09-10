defmodule WorkingWithMultipleProcesses06 do
  def pmap(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (
        IO.inspect "me = #{inspect me}"
        IO.inspect "self = #{inspect self()}"
        send me, { self(), fun.(elem) }) end
      end)
    |> Enum.map(fn (pid) ->
      receive do {^pid, result} -> result end
    end)
  end
end

# self()を遅延評価させないと、子プロセスのPIDになってしまうからmeという変数に代入しておかないといけない。
# iex(1)> WorkingWithMultipleProcesses06.pmap 1..10, &(&1 * &1)
# "me = #PID<0.84.0>"
# "me = #PID<0.84.0>"
# "me = #PID<0.84.0>"
# "me = #PID<0.84.0>"
# "me = #PID<0.84.0>"
# "me = #PID<0.84.0>"
# "me = #PID<0.84.0>"
# "me = #PID<0.84.0>"
# "me = #PID<0.84.0>"
# "me = #PID<0.84.0>"
# "self = #PID<0.86.0>"
# "self = #PID<0.90.0>"
# "self = #PID<0.87.0>"
# "self = #PID<0.88.0>"
# "self = #PID<0.89.0>"
# "self = #PID<0.91.0>"
# "self = #PID<0.92.0>"
# "self = #PID<0.93.0>"
# "self = #PID<0.94.0>"
# "self = #PID<0.95.0>"
# [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]