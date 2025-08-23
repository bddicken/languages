use "time"

primitive _Stats
  fun mean(a: Array[F64] box): F64 =>
    if a.size() == 0 then 0
    else
      var s: F64 = 0
      for x in a.values() do s = s + x end
      s / a.size().f64()
    end

  fun variance(a: Array[F64] box): F64 =>
    let n = a.size()
    if n < 2 then 0 else
      let m = mean(a)
      var ss: F64 = 0
      for x in a.values() do
        let d = x - m
        ss = ss + (d * d)
      end
      ss / (n - 1).f64()
    end

  fun stddev(a: Array[F64] box): F64 =>
    variance(a).sqrt()

primitive Benchmark
  fun bench(run_ms: I64, work: {(): I64} val): (Array[F64] val, I64) =>
    let times = recover iso Array[F64] end
    var result: I64 = 0
  let ms: I64 = if run_ms < 0 then 0 else run_ms end
  let target_ns: U64 = ms.u64() * 1_000_000
    var acc_ns: U64 = 0
    while acc_ns < target_ns do
      let start = Time.nanos()
      result = work()
      let stop = Time.nanos()
      let elapsed_ns: U64 = if stop >= start then stop - start else 0 end
      times.push(elapsed_ns.f64() / 1_000_000)
      acc_ns = acc_ns + elapsed_ns
    end
  (recover val consume times end, result)

  fun format_bench(times: Array[F64] box, result: I64): String =>
    if times.size() == 0 then
      "0,0,0,0,0," + result.string()
    else
      var min_v: F64 = 1.0/0.0
      var max_v: F64 = 0
      for x in times.values() do
        if x < min_v then min_v = x end
        if x > max_v then max_v = x end
      end
      let mean_v = _Stats.mean(times)
      let sd_v = _Stats.stddev(times)
      let n = times.size()
      mean_v.string() + "," + sd_v.string() + "," + min_v.string() + "," + max_v.string() + "," + n.string() + "," + result.string()
  end
