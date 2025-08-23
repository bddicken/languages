use "time"

class RNG
  var _state: U64
  new create(seed: U64) =>
    _state = if seed == 0 then 1 else seed end
  fun ref next(): U64 =>
    _state = (_state * 6364136223846793005) + 1
    _state

primitive Parse
  fun i64(s: String): I64 =>
    var acc: I64 = 0
    for c in s.values() do
      if (c >= 48) and (c <= 57) then
        acc = (acc * 10) + (c.i64() - 48)
      end
    end
    acc

actor Main
  new create(env: Env) =>
    try
      let args = env.args
      if args.size() < 2 then error end
      let u: I64 = Parse.i64(args(1)?)

      let rng = RNG(Time.nanos())
      let r: I64 = (rng.next() % 10000).i64()

      let a = Array[I64].init(0, 10000)

      var i: I64 = 0
      while i < 10000 do
        var j: I64 = 0
        while j < 100000 do
          let idx = i.usize()
          try a.update(idx, (a(idx)? + (j % u)))? end
          j = j + 1
        end
        let idx2 = i.usize()
        try a.update(idx2, a(idx2)? + r)? end
        i = i + 1
      end

      try env.out.print(a(r.usize())?.string()) end
      env.exitcode(0)
    else
      env.err.print("usage: code <u>")
      env.exitcode(1)
    end
