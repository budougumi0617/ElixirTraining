defmodule WorkingWithMultipleProcesses07 do
  import :timer, only: [ sleep: 1 ]

  # ^pidにすることで、receiveした順序ではなく、生成したプロセスの順序で二回目のEnum.mapを処理される。
  def pmap(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (
        sleep 500
        send me, { self(), fun.(elem) }) end
      end)
    |> Enum.map(fn (pid) ->
      receive do {^pid, result} -> result end
    end)
  end

  # 完了した順で二回目のEnum.mapが処理される
  def pmap_unsort(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (
        sleep 500
        send me, { self(), fun.(elem) }) end
      end)
    |> Enum.map(fn (_pid) ->
      receive do {_pid, result} -> result end
    end)
  end
end

# ^pidを使わないと、結果の配列の要素順が不定になる。
# iex(14)> WorkingWithMultipleProcesses07.pmap_unsort 1..40, &(&1 * &1)
# [484, 1, 4, 16, 25, 36, 9, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289,
#  324, 361, 400, 441, 529, 576, 676, 729, 625, 784, 841, 900, 961, 1024, 1089,
#  1156, 1225, 1296, 1369, 1444, 1521, 1600]
# iex(15)> WorkingWithMultipleProcesses07.pmap_unsort 1..40, &(&1 * &1)
# [484, 625, 676, 1, 4, 16, 9, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225,
#  256, 289, 324, 361, 400, 441, 529, 576, 729, 784, 841, 900, 961, 1024, 1089,
#  1156, 1225, 1296, 1369, 1444, 1521, 1600]
# iex(16)> WorkingWithMultipleProcesses07.pmap_unsort 1..40, &(&1 * &1)
# [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289, 324,
#  361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900, 961, 1089, 1156,
#  1225, 1024, 1296, 1369, 1444, 1521, 1600]
# iex(17)> WorkingWithMultipleProcesses07.pmap_unsort 1..40, &(&1 * &1)
# [484, 1, 529, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256,
#  289, 324, 361, 400, 441, 576, 625, 676, 729, 784, 841, 900, 961, 1024, 1089,
#  1156, 1225, 1296, 1369, 1444, 1521, 1600]
# iex(18)> WorkingWithMultipleProcesses07.pmap_unsort 1..40, &(&1 * &1)
# [484, 1, 529, 576, 4, 625, 9, 676, 16, 729, 784, 25, 36, 64, 81, 49, 100, 121,
#  144, 169, 196, 225, 256, 289, 324, 361, 400, 441, 841, 900, 961, 1024, 1089,
#  1156, 1225, 1296, 1369, 1444, 1521, 1600]


# iex(19)> WorkingWithMultipleProcesses07.pmap 1..40, &(&1 * &1)
# [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289, 324,
#  361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900, 961, 1024, 1089,
#  1156, 1225, 1296, 1369, 1444, 1521, 1600]
# iex(20)> WorkingWithMultipleProcesses07.pmap 1..40, &(&1 * &1)
# [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289, 324,
#  361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900, 961, 1024, 1089,
#  1156, 1225, 1296, 1369, 1444, 1521, 1600]
# iex(21)> WorkingWithMultipleProcesses07.pmap 1..40, &(&1 * &1)
# [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289, 324,
#  361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900, 961, 1024, 1089,
#  1156, 1225, 1296, 1369, 1444, 1521, 1600]
