```iex
$ iex --sname node_one
Erlang/OTP 20 [erts-9.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.5.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(node_one@budougumi0617-mac)1> fun = fn -> IO.puts(Enum.join(File.ls!, ",")) end
#Function<20.99386804/0 in :erl_eval.expr/5>
iex(node_one@budougumi0617-mac)2> Node.connect :"node_two@budougumi0617-mac"
true
iex(node_one@budougumi0617-mac)3> Node.spawn(:"node_two@budougumi0617-mac", fun)
#PID<10230.95.0>
issues,issues.ex
iex(node_one@budougumi0617-mac)4> spawn(fun)
#PID<0.100.0>
ch01,ch02,ch05,ch06,ch07,ch10,ch11,ch12,ch14,ch15,elixir_traing.ex
```

---

```
$ iex --sname node_two
Erlang/OTP 20 [erts-9.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.5.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(node_two@budougumi0617-mac)1> spawn(fun)
** (CompileError) iex:1: undefined function fun/0

iex(node_two@budougumi0617-mac)1> Node.spawn(:"node_one@budougumi0617-mac", fun)
** (CompileError) iex:1: undefined function fun/0
    (stdlib) lists.erl:1354: :lists.mapfoldl/3
    (stdlib) lists.erl:1355: :lists.mapfoldl/3
iex(node_two@budougumi0617-mac)1>
```