# StringAndBinaries-3
なぜ、iexは`'cat'`をもじれつとして表示しているのに、`'dog'`を文字コードで表示しているのだろう？

# Answer
`d, o, g`という3つ要素として認識しているから。
```
iex(2)> a = ['cat' | 'dog']
['cat', 100, 111, 103]
iex(3)> IO.inspect a
['cat', 100, 111, 103]
['cat', 100, 111, 103]
iex(4)> length a
4
```