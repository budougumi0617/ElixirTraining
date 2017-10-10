```iex
$ iex --sname node_one
Erlang/OTP 20 [erts-9.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.5.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(node_one@budougumi0617-mac)1> Node.connect :"node_two@budougumi0617-mac"
true
iex(node_one@budougumi0617-mac)2> fun = fn -> IO.puts(Enu.Join(File.ls!, ",")) end
** (SyntaxError) iex:2: syntax error before: '('

iex(node_one@budougumi0617-mac)2> fun = fn -> IO.puts(Enu.join(File.ls!, ",")) end
#Function<20.99386804/0 in :erl_eval.expr/5>
iex(node_one@budougumi0617-mac)3> spawn(fun)
#PID<0.100.0>
iex(node_one@budougumi0617-mac)4>
23:47:20.101 [error] Error in process #PID<0.100.0> on node :"node_one@budougumi0617-mac" with exit value:
{:undef,
 [{Enu, :join,
   [["ch01", "ch02", "ch05", "ch06", "ch07", "ch10", "ch11", "ch12", "ch14",
     "elixir_traing.ex"], ","], []},
  {:erl_eval, :do_apply, 6, [file: 'erl_eval.erl', line: 670]},
  {:erl_eval, :expr_list, 6, [file: 'erl_eval.erl', line: 878]},
  {:erl_eval, :expr, 5, [file: 'erl_eval.erl', line: 404]}]}


nil
iex(node_one@budougumi0617-mac)5> spawn(:"node_two@budougumi0617-mac", fun)
** (CompileError) iex:5: undefined function spawn/2

iex(node_one@budougumi0617-mac)5> Node.spawn(:"node_two@budougumi0617-mac", fun)
#PID<9728.97.0>
iex(node_one@budougumi0617-mac)6>
23:50:21.556 [error] Error in process #PID<9728.97.0> on node :"node_two@budougumi0617-mac" with exit value:
{:undef,
 [{Enu, :join, [["issues", "issues.ex"], ","], []},
  {:erl_eval, :do_apply, 6, [file: 'erl_eval.erl', line: 670]},
  {:erl_eval, :expr_list, 6, [file: 'erl_eval.erl', line: 878]},
  {:erl_eval, :expr, 5, [file: 'erl_eval.erl', line: 404]}]}
```

---

```
$ iex --sname node_two
Erlang/OTP 20 [erts-9.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.5.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(node_two@budougumi0617-mac)1> spawn(fun)
** (CompileError) iex:1: undefined function fun/0

iex(node_two@budougumi0617-mac)1> Node.list
[:"node_one@budougumi0617-mac"]
iex(node_two@budougumi0617-mac)2>
```