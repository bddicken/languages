import gleam/int
import gleam/list

pub fn loops(u: Int) -> Int {
  // Get a random number 0 <= r < 10k
  let r = int.random(10_000)
  let a = list.repeat(0, 10_000)
  let b = list.range(0, 9999)
  let new_a =
    list.map(a, fn(x) {
      // 10k inner loop iterations, per outer loop iteration
      let inner_sum =
        list.fold(b, x, fn(x, y) {
          // Simple sum
          x + { y % u }
        })
      // Add a random value to each element in array
      inner_sum + r
    })

  // Return the r-th element of the list
  case list.drop(new_a, r) {
    [first, ..] -> first
    _ -> -1
  }
}
