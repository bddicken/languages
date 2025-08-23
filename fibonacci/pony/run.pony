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

primitive Fib
  fun fib(n: I64): I64 => if n < 2 then n else fib(n - 1) + fib(n - 2) end
  // Intentionally naive recursion; benchmark computes fib(u).


actor Main
  new create(env: Env) =>
    try
      let args = env.args
      if args.size() < 4 then error end
      let run_ms = Parse.i64(args(1)?)
      let warmup_ms = Parse.i64(args(2)?)
    let u = Parse.i64(args(3)?)

  let work = recover val {(): I64 => Fib.fib(u) } end
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
