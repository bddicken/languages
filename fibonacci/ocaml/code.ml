

let fibonacci n =
  let rec aux a b n =
    if n = 0 then a
    else aux b (a + b) (n - 1)
  in
  aux 0 1 n

  
let () =
let u = int_of_string Sys.argv.(1) in
let r = ref 0 in
    for i = 1 to u - 1 do
      r := !r + fibonacci i
    done;
    Printf.printf "%d" !r