import std/[strutils, os]
proc fibonacci(n: uint32): uint32 =
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

let u: uint32 = paramStr(1).parseInt().uint32
var r: uint32
for i in 1..u:
    r += fibonacci(i)
echo r