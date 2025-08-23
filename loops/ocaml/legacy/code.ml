let main argv =
  if Array.length argv < 2 then (
    prerr_endline "usage: code <u>";
    exit 1
  );
  let u = int_of_string argv.(1) in
  Random.self_init ();
  let r = Random.int 10000 in
  let a = Array.make 10000 0 in
  for i = 0 to 9999 do
    for j = 0 to 99_999 do
      a.(i) <- a.(i) + (j mod u)
    done;
    a.(i) <- a.(i) + r
  done;
  Printf.printf "%d\n" a.(r);
  0

let () =
  exit (main Sys.argv)
