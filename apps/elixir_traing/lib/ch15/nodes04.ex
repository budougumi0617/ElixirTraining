defmodule Ticker do

  @interval 2000 # 2 seconds
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    # @nameという名前でpidを登録しておく。
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    # @nameという名前で登録されているpidに対してメソッドを呼び出す。
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator(Enum.reverse([pid|clients]))
    after
      @interval ->
        IO.puts "tick"
        case clients do
          [ head | tail ] ->
            send head, { :tick }
            generator( tail ++ [ head ]) # Poor performance.
          [ client ] ->
            send client, { :tick }
            generator(client)
          [] ->
            generator([])
        end
    end
  end
end

defmodule Client do
  @interval 2000 # 2 seconds
  @head     :head
  @next     :next

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    # Ticker.register(pid)
    # 最初のClientはheadとして登録しておく？
    # 「次に送信PID」みたいな場所に登録する
    # 登録してあるのが自分だったら、自分より新しいnodeがないので、headに通知する。そうするとリングになる？
    # iex(1)> :global.whereis_name('tst')
    # :undefined
  end

  def receiver do
    receive do
      { :tick  } ->
        IO.puts "took in client #{inspect self()}"
        receiver()
    end
  end
end
