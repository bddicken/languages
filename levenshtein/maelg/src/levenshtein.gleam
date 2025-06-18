import gleam/int
import gleam/list
import gleam/result
import gleam/string

// TODO: This is WAAAAYYYY to slow and will finish in some years time for the default input file

fn get_or(lst: List(Int), idx: Int) -> Int {
  lst
  |> list.drop(idx)
  |> list.first()
  |> result.unwrap(0)
}

fn levenshtein_distance(s1: String, s2: String) -> Int {
  // Ensure s1 is the shorter string to minimize space usage
  let #(s1, s2) = case string.length(s1) > string.length(s2) {
    True -> #(s2, s1)
    False -> #(s1, s2)
  }

  let m = string.length(s1)
  let n = string.length(s2)

  // Process all rows and get final distance
  let #(final_row, _) =
    list.range(1, n)
    |> list.fold(#(list.range(0, m), list.range(0, m)), fn(row, i) {
      let #(prev, _) = row
      // Initialize current row with first value as i
      let curr = [i, ..list.range(1, m)]

      let new_curr =
        list.range(1, m)
        |> list.fold(curr, fn(acc, j) {
          let cost = case
            string.slice(s1, j - 1, 1) == string.slice(s2, i - 1, 1)
          {
            True -> 0
            False -> 1
          }

          // Calculate the three operations
          let del = get_or(prev, j) + 1
          let ins = get_or(acc, j - 1) + 1
          let sub = get_or(prev, j - 1) + cost

          // Update current position with minimum
          list.append(list.take(acc, j), [
            int.min(del, int.min(ins, sub)),
            ..list.drop(acc, j + 1)
          ])
        })
      #(new_curr, new_curr)
    })

  get_or(final_row, m)
}

pub fn distances(strings: List(String)) -> List(Int) {
  list.combinations(strings, 2)
  |> list.map(fn(pair) {
    case pair {
      [s1, s2] -> levenshtein_distance(s1, s2)
      _ -> 0
    }
  })
}
