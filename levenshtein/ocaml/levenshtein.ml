let levenshtein_distance s1 s2 =
  let m = String.length s1 in
  let n = String.length s2 in
  if m = 0 then n
  else if n = 0 then m
  else
    let s1, s2, m, n = if m > n then s2, s1, n, m else s1, s2, m, n in
    let prev = Array.init (m + 1) (fun i -> i) in
    let curr = Array.make (m + 1) 0 in
    for j = 1 to n do
      curr.(0) <- j;
      for i = 1 to m do
        let cost = if s1.[i - 1] = s2.[j - 1] then 0 else 1 in
        let del = prev.(i) + 1 in
        let ins = curr.(i - 1) + 1 in
        let sub = prev.(i - 1) + cost in
        curr.(i) <- min (min del ins) sub
      done;
      Array.blit curr 0 prev 0 (m + 1)
    done;
    prev.(m)

let distances_sum strings =
  let rec outer i acc =
    if i >= Array.length strings then acc
    else
      let rec inner j acc2 =
        if j >= Array.length strings then acc2
        else
          let d = levenshtein_distance strings.(i) strings.(j) in
          inner (j + 1) (acc2 + d)
      in
      outer (i + 1) (inner (i + 1) acc)
  in
  outer 0 0
