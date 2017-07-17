# 浮動小数点数を二つの10進数からなる文字列に変換する(Erlang)
```elixir
iex(2)> :io.format("~4.2f", [3.14444])
3.14:ok
```
# オペレーティング・システムの環境変数を取り出す(Elixir)
```elixir
iex(4)> System.get_env("SHELL")
"/usr/local/bin/zsh"
```
# ファイル名の拡張子を取り出す(Elixir)
```elixir
iex(3)> Path.extname("foo.txt")
".txt"
```
# プロセスのカレントワーキングディレクトリを返す(Elixir)
```elixir
iex(2)> System.cwd
"/Users/budougumi0617/go/src/github.com/budougumi0617/ElixirTraining"
```
# JSON文字列を、Elixirのデータ構造に変換する(Elixir)
https://github.com/cblage/elixir-json  
https://github.com/devinus/poison
# オペレーションシステムのシェルでコマンドを実行する。
```elixir
iex(1)> System.cmd "pwd", []{"/Users/budougumi0617/go/src/github.com/budougumi0617/ElixirTraining\n", 0}
```