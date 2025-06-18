import argv
import benchmark
import gleam/int
import gleam/io
import gleam/result
import loops

pub fn main() -> Int {
  case argv.load().arguments {
    [run_ms_str, warmup_ms_str, n_str] -> {
      let run_ms = int.base_parse(run_ms_str, 10) |> result.unwrap(0)
      let warmup_ms = int.base_parse(warmup_ms_str, 10) |> result.unwrap(0)
      let u = int.base_parse(n_str, 10) |> result.unwrap(0)

      // Warmup run (results discarded)
      let _warmup = benchmark.run(fn() { loops.loops(u) }, warmup_ms)

      // Benchmark run
      let result = benchmark.run(fn() { loops.loops(u) }, run_ms)
      io.println(benchmark.format_results(result, result.result))
      0
    }

    _ -> {
      io.println("Usage: run <run_ms> <warmup_ms> <n>")
      1
    }
  }
}
