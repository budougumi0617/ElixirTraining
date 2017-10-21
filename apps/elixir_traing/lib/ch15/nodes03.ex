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
      # タイムアウトの設定
      @interval ->
        IO.puts "tick"
      Enum.each clients, fn client  ->
        send client, { :tick }
      end
      generator(clients)
    end
  end
end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick  } ->
        IO.puts "took in client #{inspect self()}"
        receiver()
    end
  end
end
