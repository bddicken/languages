import os, strutils

proc fibonacci(n: int): int =
  if n == 0:
    return 0
  elif n == 1:
    return 1
  else:
    return fibonacci(n - 1) + fibonacci(n - 2)

let u = paramStr(1).parseInt()
var r = 0

for i in 0..<u:
  r += fibonacci(i)

echo r