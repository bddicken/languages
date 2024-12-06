import std/[
  strutils,
  cmdline
  ]

proc fibonacci(n: uint64): uint64 =
  if n <= 1:
    return n
  return fibonacci(n - 1) + fibonacci(n - 2)

proc main() =
  let u = uint64 parseUInt paramStr 1
  var r: uint64 = 0
  for i in 1..u:
    r += fibonacci(i)
  echo r

main()
