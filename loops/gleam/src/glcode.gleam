import argv
import gleam/int
import gleam/io
import gleam/yielder
import prng/random
import prng/seed

pub fn main() {
  case argv.load().arguments {
    ["number", number] -> {
      // Get an input number from the command line
      let assert Ok(number) = number |> int.parse
      // Get a random number 1 <= r <= 10k
      let seed = seed.new(69)
      let r = random.int(1, 10_000) |> random.sample(seed)
      // "List" of 10k elements initialized to 0 // 10k outer loop iterations
      yielder.range(0, 10_000)
      |> yielder.fold(0, fn(acc, x) {
        // 100k inner loop iterations, per outer loop iteration
        yielder.range(1, 10_000)
        // Simple sum
        |> yielder.fold(0, fn(acc, i) { acc + { i % number } })
        // Add random value
        |> int.add(r)
        // Add current value
        |> int.add(x)
        // Add to te sum
        |> int.add(acc)
      })
      |> int.to_string
      |> io.println
    }

    _ -> io.println("Usage: glcode number [number]")
  }
}
