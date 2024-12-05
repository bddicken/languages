import std/[os, random, strutils]

proc main {.inline.} =
  let
    n = paramStr(1)
      .parseUint()
    
    r = rand(0 .. 10000).uint64

  var a: array[10000, uint]

  for i in 0 ..< 10000:
    for j in 0 ..< 10000:
      a[i] = a[i] + j.uint mod n

    a[i] += r

  echo $(a[r])

when isMainModule: main()