use "time"
use "../../lib/pony/benchmark"

primitive Parse
  fun i64(s: String): I64 =>
    var acc: I64 = 0
    var neg = false
    for c in s.values() do
      if c == 45 then
        neg = true
      elseif (c >= 48) and (c <= 57) then
        acc = (acc * 10) + (c.i64() - 48)
      end
    end
    if neg then -acc else acc end

class RNG
  var _state: U64 = 0
  new create(seed: U64) =>
    _state = if seed == 0 then 1 else seed end
  fun ref next(): U64 =>
    _state = (_state * 6364136223846793005) + 1
    _state

primitive Loops
  fun apply(u: I64): I64 =>
    let rng = RNG(Time.nanos())
    let r: I64 = (rng.next() % 10000).i64()
    let a = Array[I64].init(0, 10000)
    var i: I64 = 0
    while i < 10000 do
      var j: I64 = 0
      while j < 10000 do
        let idx = i.usize()
        try a.update(idx, a(idx)? + (j % u))? end
        j = j + 1
      end
      let idx2 = i.usize()
      try a.update(idx2, a(idx2)? + r)? end
      i = i + 1
    end
  try a(r.usize())? else 0 end

actor Main
  new create(env: Env) =>
    try
      let args = env.args
      if args.size() < 4 then error end
      let run_ms = Parse.i64(args(1)?)
      let warmup_ms = Parse.i64(args(2)?)
      let u = Parse.i64(args(3)?)

  let work = recover val {(): I64 => Loops(u) } end
      if warmup_ms > 0 then
        Benchmark.bench(warmup_ms, work)
      end
  let tr = Benchmark.bench(run_ms, work)
  let times = tr._1
  let result = tr._2
  env.out.print(Benchmark.format_bench(times, result))
      env.exitcode(0)
    else
      env.err.print("Usage: run <run_ms> <warmup_ms> <u>")
      env.exitcode(1)
    end
