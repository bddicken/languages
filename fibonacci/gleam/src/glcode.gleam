import argv
import gleam/int
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["number", number] -> {
      let assert Ok(number) = number |> int.parse
      fibonacci(number)
      |> int.to_string
      |> io.println
    }

    _ -> io.println("Usage: glcode number [number]")
  }
}

fn fibonacci(i: Int) -> Int {
  case i {
    0 -> 1
    1 -> 1
    _ -> fibonacci(i - 1) + fibonacci(i - 2)
  }
}
