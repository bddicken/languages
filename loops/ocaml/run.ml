let variance arr =
  let n = float_of_int (List.length arr) in
  if n < 2. then 0.
  else
    let mean = (List.fold_left ( +. ) 0. arr) /. n in
    let sumsq = List.fold_left (fun acc x -> let d = x -. mean in acc +. (d *. d)) 0. arr in
    sumsq /. (n -. 1.)

let std_dev arr = sqrt (variance arr)

let bench run_ms f =
  let run_s = (float_of_int run_ms) /. 1000. in
  let rec loop times total_s last_sec result =
    if total_s >= run_s then (List.rev times, result)
    else
      let start = Unix.gettimeofday () in
      let res = f () in
      let stop = Unix.gettimeofday () in
      let elapsed_s = stop -. start in
      let total_s' = total_s +. elapsed_s in
      (* emit dot per second if run_ms > 1 *)
      let () =
        if run_ms > 1 then (
          let sec_now = int_of_float total_s' in
          if sec_now > last_sec then (prerr_string "."; flush stderr)
        )
      in
      loop ((elapsed_s *. 1000.) :: times) total_s' (int_of_float total_s') res
  in
  let times_ms, result = loop [] 0. 0 (f ()) in
  if run_ms > 1 then (prerr_endline "");
  (times_ms, result)

let format_bench (times_ms, result) =
  match times_ms with
  | [] -> failwith "no data!"
  | _ ->
      let n = float_of_int (List.length times_ms) in
      let mean = (List.fold_left ( +. ) 0. times_ms) /. n in
      let sd = std_dev times_ms in
      let min_v = List.fold_left min infinity times_ms in
      let max_v = List.fold_left max neg_infinity times_ms in
      Printf.sprintf "%f,%f,%f,%f,%d,%d" mean sd min_v max_v (List.length times_ms) result

let parse_args argv =
  if Array.length argv < 4 then (
    prerr_endline "usage: run <run_ms> <warmup_ms> <u>";
    exit 1
  );
  let run_ms = int_of_string argv.(1) in
  let warmup_ms = int_of_string argv.(2) in
  let u = int_of_string argv.(3) in
  (run_ms, warmup_ms, u)

let () =
  let run_ms, warmup_ms, u = parse_args Sys.argv in
  (* Warmup *)
  if warmup_ms > 0 then ignore (bench warmup_ms (fun () -> Loops.loops u));
  (* Benchmark *)
  let result = bench run_ms (fun () -> Loops.loops u) in
  print_endline (format_bench result)
