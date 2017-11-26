defmodule OtpServer.OtpServer do
  use GenServer

  #####
  # External API

  def start_link(current_stack) do
    GenServer.start_link(__MODULE__, current_stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(elem) do
    GenServer.cast(__MODULE__, {:push, elem})
  end

  #####
  # Server implementations

  def handle_call(:pop, _from, current_stack) do
    [ head | tail ] = current_stack
    { :reply, head, tail }
  end

  # 返事を必要としないのでhandle_cast
  # 戻り値は:noreplyと新しい状態のみ。
  def handle_cast({:push, e}, current_stack) do # 戻さないのでクライアントのPID(from)もいらない。
    if e == 'err' do
      IO.puts 'got err'
      System.halt 0
    end
   { :noreply, [ e | current_stack ]}
  end

  def terminate(state, reason) do
    IO.puts "state : #{inspect state}"
    IO.puts "reason : #{inspect reason}"
  end
end

# $ iex -S mix
# iex -S mix
# Erlang/OTP 20 [erts-9.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
#
# Interactive Elixir (1.5.1) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> OtpServer.OtpServer.
# pop/0           push/1          start_link/1
# iex(1)> OtpServer.OtpServer.pop
# 123
# iex(2)> OtpServer.OtpServer.pop
# state : {{:badmatch, []}, [{OtpServer.OtpServer, :handle_call, 3, [file: 'lib/myserver/otp_server.ex', line: 23]}, {:gen_server, :try_handle_call, 4, [file: 'gen_server.erl', line: 636]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 665]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 247]}]}
# reason : []
# ** (exit) exited in: GenServer.call(OtpServer.OtpServer, :pop, 5000)
#    ** (EXIT) an exception was raised:
#        ** (MatchError) no match of right hand side value: []
#            (sequence) lib/myserver/otp_server.ex:23: OtpServer.OtpServer.handle_call/3
#            (stdlib) gen_server.erl:636: :gen_server.try_handle_call/4
#            (stdlib) gen_server.erl:665: :gen_server.handle_msg/6
#            (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
#    (elixir) lib/gen_server.ex:774: GenServer.call/3
# iex(2)>
# 21:18:57.626 [error] GenServer OtpServer.OtpServer terminating
# ** (MatchError) no match of right hand side value: []
#     (sequence) lib/myserver/otp_server.ex:23: OtpServer.OtpServer.handle_call/3
#     (stdlib) gen_server.erl:636: :gen_server.try_handle_call/4
#     (stdlib) gen_server.erl:665: :gen_server.handle_msg/6
#     (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
# Last message (from #PID<0.122.0>): :pop
# State: []
# Client #PID<0.122.0> is alive
#     (stdlib) gen.erl:169: :gen.do_call/4
#     (elixir) lib/gen_server.ex:771: GenServer.call/3
#     (stdlib) erl_eval.erl:670: :erl_eval.do_apply/6
#     (elixir) src/elixir.erl:239: :elixir.eval_forms/4
#     (iex) lib/iex/evaluator.ex:219: IEx.Evaluator.handle_eval/5
#     (iex) lib/iex/evaluator.ex:200: IEx.Evaluator.do_eval/3
#     (iex) lib/iex/evaluator.ex:178: IEx.Evaluator.eval/3
#     (iex) lib/iex/evaluator.ex:77: IEx.Evaluator.loop/1
# 
# 
# nil
# iex(3)> OtpServer.OtpServer.push 10
# :ok
# iex(4)> OtpServer.OtpServer.pop
# 10
