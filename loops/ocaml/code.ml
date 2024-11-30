let () = Random.self_init ()

let () =
    let u = int_of_string Sys.argv.(1) in 
    let r = Random.int 10000 in 
    let a = Array.make 10000 0 in 

    for i = 0 to 9999 do
      for j = 0 to 99999 do
        a.(i) <- a.(i) + (j mod u); 
      done;
      a.(i) <- a.(i) + r; 
    done;
    
    Printf.printf "%d" a.(r)
