import argv
import gleam/int
import gleam/io
import gleam/list

pub fn main() {
  let args = argv.load().arguments

  let r = int.random(10_000)
  // Get a random number 0 <= r < 10k

  let a = list.repeat(0, 10_000)
  // Array of 10k elements initialized to 0
  let b = list.range(0, 99_999)

  case args {
    [input] -> {
      case int.parse(input) {
        Ok(u) -> {
          let new_a =
            list.map(a, fn(x) {
              // 100k inner loop iterations, per outer loop iteration
              let inner_sum =
                list.fold(b, x, fn(x, y) {
                  x + { y % u }
                  // Simple sum
                })
              inner_sum + r
              // Add a random value to each element in array
            })

          // Print the r-th element of the list
          let elem = case list.drop(new_a, r) {
            [first, ..] -> first
            _ -> -1
          }
          io.debug(elem)
        }
        Error(_) -> io.debug(-1)
      }
    }
    _ -> io.debug(-1)
  }
}
