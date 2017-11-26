defmodule OtpServer.OtpServer05 do
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
# Erlang/OTP 20 [erts-9.0.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
#
# Interactive Elixir (1.5.1) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> OtpServer.OtpServer05.start_link []
# {:ok, #PID<0.121.0>}
# iex(2)> OtpServer.OtpServer05.pop
# state : {{:badmatch, []}, [{OtpServer.OtpServer05, :handle_call, 3, [file: 'lib/otp-servers05/otp_servers05.ex', line: 23]}, {:gen_server, :try_handle_call, 4, [file: 'gen_server.erl', line: 636]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 665]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 247]}]}
# reason : []
# ** (EXIT from #PID<0.119.0>) evaluator process exited with reason: an exception was raised:
#     ** (MatchError) no match of right hand side value: []
#         (ch16) lib/otp-servers05/otp_servers05.ex:23: OtpServer.OtpServer05.handle_call/3
#         (stdlib) gen_server.erl:636: :gen_server.try_handle_call/4
# iex(2)> OtpServer.OtpServer05.start_link []
# {:ok, #PID<0.126.0>}
# iex(3)> OtpServer.OtpServer05.push 'err'
# got err
# :ok

