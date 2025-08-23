use "time"
use "files"
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

primitive Levenshtein
  fun dist(a: String box, b: String box): I64 =>
    let m = a.size().i64()
    let n = b.size().i64()
    if m == 0 then n elseif n == 0 then m else
      var s1 = a; var s2 = b; var mm = m; var nn = n
      if mm > nn then
        s1 = b; s2 = a; mm = n; nn = m
      end
      let prev = Array[I64].init(0, (mm + 1).usize())
      let curr = Array[I64].init(0, (mm + 1).usize())
      var i: I64 = 0
      while i <= mm do
        try prev.update(i.usize(), i)? end
        i = i + 1
      end
      i = 1
      while i <= nn do
        try curr.update(0, i)? end
        var j: I64 = 1
        while j <= mm do
          let ac: U8 = try s1((j - 1).usize())? else U8(0) end
          let bc: U8 = try s2((i - 1).usize())? else U8(0) end
          let cost: I64 = if ac == bc then 0 else 1 end
          let del = (try prev(j.usize())? else 0 end) + 1
          let ins = (try curr((j - 1).usize())? else 0 end) + 1
          let sub = (try prev((j - 1).usize())? else 0 end) + cost
          let v =
            if del < ins then
              if del < sub then del else sub end
            else
              if ins < sub then ins else sub end
            end
          try curr.update(j.usize(), v)? end
          j = j + 1
        end
        var k: I64 = 0
        while k <= mm do
          try prev.update(k.usize(), try curr(k.usize())? else 0 end)? end
          k = k + 1
        end
        i = i + 1
      end
      try prev(mm.usize())? else 0 end
    end


actor Main
  new create(env: Env) =>
    try
      let args = env.args
      if args.size() < 4 then error end
      let run_ms = Parse.i64(args(1)?)
      let warmup_ms = Parse.i64(args(2)?)
      let input_path = args(3)?

  // Read lines into an iso builder then freeze to val
  var builder = recover iso Array[String] end
      let auth = FileAuth(env.root)
      let p = FilePath(auth, input_path)
      let file = File.open(p)
      for line in file.lines() do
        builder.push(recover val consume line end)
      end
      let arr: Array[String] val = recover val consume builder end

      let work =
        recover val {(): I64 =>
          var sum: I64 = 0
          let n: USize = arr.size()
          var i: USize = 0
          while i < n do
            var j: USize = i + 1
            while j < n do
              let si = try arr(i)? else "" end
              let sj = try arr(j)? else "" end
              sum = sum + Levenshtein.dist(si, sj)
              j = j + 1
            end
            i = i + 1
          end
          sum
        }
      end

  if warmup_ms > 0 then Benchmark.bench(warmup_ms, work) end
  let tr = Benchmark.bench(run_ms, work)
  let times = tr._1
  let result = tr._2
  env.out.print(Benchmark.format_bench(times, result))
      env.exitcode(0)
    else
      env.err.print("Usage: run <run_ms> <warmup_ms> <input_path>")
      env.exitcode(1)
    end
