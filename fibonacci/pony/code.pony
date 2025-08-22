primitive Parse
  fun i64(s: String): I64 =>
    var acc: I64 = 0
    for c in s.values() do
      if (c >= 48) and (c <= 57) then
        acc = (acc * 10) + (c.i64() - 48)
      end
    end
    acc

primitive Fib
  fun fib(n: I64): I64 =>
    if n < 2 then n else fib(n - 1) + fib(n - 2) end

actor Main
  new create(env: Env) =>
    try
      let args = env.args
      if args.size() < 2 then error end
      let u: I64 = Parse.i64(args(1)?)

      var r: I64 = 0
      var i: I64 = 1
      while i < u do
        r = r + Fib.fib(i)
        i = i + 1
      end

      env.out.print(r.string())
      env.exitcode(0)
    else
      env.err.print("usage: code <u>")
      env.exitcode(1)
    end
