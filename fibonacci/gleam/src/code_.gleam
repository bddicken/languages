import argv
import gleam/int
import gleam/io

fn fibonacci(n: Int) -> Int {
  case n {
    0 -> 0
    1 -> 1
    _ -> fibonacci(n - 1) + fibonacci(n - 2)
  }
}

fn sum_fibonacci(u: Int) -> Int {
  case u {
    0 -> 0
    _ -> fibonacci(u - 1) + sum_fibonacci(u - 1)
  }
}

pub fn main() {
  let args = argv.load().arguments

  case args {
    [input] -> {
      let result = case int.parse(input) {
        Ok(value) -> sum_fibonacci(value)
        Error(_) -> -1
      }
      io.debug(result)
    }
    _ -> io.debug(-1)
  }
}
