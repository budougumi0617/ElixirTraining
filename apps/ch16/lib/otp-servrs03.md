# 練習問題:OTP-Servers-3
練習問題で作ってきたスタックサーバプロセスに名前をつけよう。
そして`iex`でその名前でアクセスできるか試してみよう。

# 解答

```
iex(1)> GenServer.start_link(Push.OtpServer02, [5, "cat", 9], name: :stack)
{:ok, #PID<0.133.0>}
iex(2)> GenServer.call(:stack, :pop)
5
```
