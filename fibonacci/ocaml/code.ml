let rec fibonacci n =
  if n < 2 then n else fibonacci (n - 1) + fibonacci (n - 2)

let main argv =
  if Array.length argv < 2 then (
    prerr_endline "usage: code <u>";
    1
  ) else (
    let u = int_of_string argv.(1) in
    let r = ref 0 in
    for i = 1 to u - 1 do
      r := !r + fibonacci i
    done;
    Printf.printf "%d\n" !r;
    0
  )

let () = exit (main Sys.argv)
