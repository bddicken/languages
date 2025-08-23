let loops u =
  Random.self_init ();
  let r = Random.int 10000 in
  let a = Array.make 10000 0 in
  for i = 0 to 9999 do
    for j = 0 to 9999 do
      a.(i) <- a.(i) + (j mod u)
    done;
    a.(i) <- a.(i) + r
  done;
  a.(r)
