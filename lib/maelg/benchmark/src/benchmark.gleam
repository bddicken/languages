import gleam/erlang
import gleam/float
import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub type Stats(a) {
  Stats(
    mean_ms: Float,
    std_dev_ms: Float,
    min_ms: Float,
    max_ms: Float,
    runs: Int,
    result: a,
  )
}

fn calculate_stats(result: BenchmarkResult(a)) -> Stats(a) {
  let runs = result.run_count
  case runs {
    0 -> Stats(0.0, 0.0, 0.0, 0.0, 0, result.last_result)
    _ -> {
      let times = result.times
      let total = list.fold(times, 0, fn(sum, x) { sum + x })
      let mean_ns = int.to_float(total) /. int.to_float(runs)
      let min_ns = int.to_float(list.fold(times, total, int.min))
      let max_ns = int.to_float(list.fold(times, 0, int.max))

      let variance =
        list.fold(times, 0.0, fn(sum, t) {
          let diff = int.to_float(t) -. mean_ns
          sum +. diff *. diff
        })
        /. int.to_float(runs)

      let std_dev_ns = case float.square_root(variance) {
        Ok(value) -> value
        Error(_) -> 0.0
      }

      Stats(
        mean_ns /. 1_000_000.0,
        std_dev_ns /. 1_000_000.0,
        min_ns /. 1_000_000.0,
        max_ns /. 1_000_000.0,
        runs,
        result.last_result,
      )
    }
  }
}

pub type BenchmarkResult(a) {
  BenchmarkResult(run_count: Int, times: List(Int), last_result: a)
}

fn run_loop(
  f: fn() -> a,
  run_ns: Int,
  times: List(Int),
  start: Int,
  last_status: Int,
  last: a,
) -> BenchmarkResult(a) {
  let now = erlang.system_time(erlang.Nanosecond)
  let elapsed = now - start
  case elapsed < run_ns {
    True -> {
      let t0 = erlang.system_time(erlang.Nanosecond)
      let result = f()
      let t1 = erlang.system_time(erlang.Nanosecond)
      let delta = t1 - t0
      case t0 - last_status > 1_000_000_000 {
        True -> {
          io.print_error(".")
          run_loop(f, run_ns, [delta, ..times], start, t1, result)
        }
        False ->
          run_loop(f, run_ns, [delta, ..times], start, last_status, result)
      }
    }
    False -> {
      io.println_error("")
      BenchmarkResult(list.length(times), times, last)
    }
  }
}

pub fn run(f: fn() -> a, run_ms: Int) -> Stats(a) {
  let benchmark_result = case run_ms {
    0 -> {
      let result = f()
      BenchmarkResult(1, [0], result)
    }
    1 -> {
      // Check-output run, no status prints
      let t0 = erlang.system_time(erlang.Nanosecond)
      let result = f()
      let t1 = erlang.system_time(erlang.Nanosecond)
      BenchmarkResult(1, [t1 - t0], result)
    }
    _ -> {
      io.print_error(".")
      let run_ns = run_ms * 1_000_000
      let start = erlang.system_time(erlang.Nanosecond)
      let last_status = start
      run_loop(f, run_ns, [], start, last_status, f())
    }
  }
  calculate_stats(benchmark_result)
}

pub fn format_results(stats: Stats(a), answer: Int) -> String {
  string.concat([
    float.to_string(stats.mean_ms),
    ",",
    float.to_string(stats.std_dev_ms),
    ",",
    float.to_string(stats.min_ms),
    ",",
    float.to_string(stats.max_ms),
    ",",
    int.to_string(stats.runs),
    ",",
    int.to_string(answer),
  ])
}
