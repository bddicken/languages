import argv
import benchmark
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import levenshtein
import simplifile

pub fn main() -> Int {
  let args = argv.load().arguments

  {
    io.println("TODO: This Levenshtein is too slow, not running it")
    // TODO: I couldn't figure out how to just exit with a value
    0 |> panic()
  }

  case args {
    [run_ms_str, warmup_ms_str, input_path] -> {
      let run_ms = int.base_parse(run_ms_str, 10) |> result.unwrap(0)
      let warmup_ms = int.base_parse(warmup_ms_str, 10) |> result.unwrap(0)

      let strings = case simplifile.read(input_path) {
        Ok(content) -> string.split(content, on: "\n")
        Error(_) -> {
          io.println_error("Could not read file: " <> input_path)
          []
        }
      }

      let work = fn() { levenshtein.distances(strings) }

      let _warmup = benchmark.run(work, warmup_ms)
      let result = benchmark.run(work, run_ms)

      let sum = list.fold(result.result, 0, fn(sum, x) { sum + x })
      io.println(benchmark.format_results(result, sum))
      0
    }

    _ -> {
      io.println("Usage: run <run_ms> <warmup_ms> <input_file>")
      1
    }
  }
}
