

let rec fibonacci n =
    if n < 2 then n
    else fibonacci (n-1) + fibonacci (n-2)
  
  
let () =
let u = int_of_string Sys.argv.(1) in
let r = ref 0 in
    for i = 1 to u - 1 do
      r := !r + fibonacci i
    done;
    Printf.printf "%d" !r