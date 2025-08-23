open Printf

let variance arr =
  let n = Array.length arr in
  if n < 2 then 0.0
  else
    let mean = Array.fold_left ( +. ) 0.0 arr /. float_of_int n in
    let sumsq = Array.fold_left (fun acc x -> let d = x -. mean in acc +. (d *. d)) 0.0 arr in
    sumsq /. float_of_int (n - 1)

let std_dev arr = sqrt (variance arr)

let bench run_ms f =
  (* Collect elapsed times in milliseconds (float) *)
  let times_ms = ref [] in
  let result = ref None in
  let run_s = (float_of_int run_ms) /. 1000.0 in
  let acc_s = ref 0.0 in
  let last_second_shown = ref 0 in
  while !acc_s < run_s do
    let start = Unix.gettimeofday () in
    let r = f () in
    let finish = Unix.gettimeofday () in
    let elapsed_s = finish -. start in
    result := Some r;
    times_ms := (elapsed_s *. 1000.0) :: !times_ms;
    acc_s := !acc_s +. elapsed_s;
    if run_ms > 1 then (
      let current_sec = int_of_float !acc_s in
      if current_sec > !last_second_shown then (
        last_second_shown := current_sec;
        prerr_string "."; flush stderr
      )
    )
  done;
  if run_ms > 1 then prerr_endline "";
  (List.rev !times_ms, Option.get !result)

let format_bench (times_ms, result) =
  match times_ms with
  | [] -> failwith "no data!"
  | _ ->
      let arr = Array.of_list times_ms in
      let n = Array.length arr in
      let mean = Array.fold_left ( +. ) 0.0 arr /. float_of_int n in
      let sd = std_dev arr in
      let min_v = Array.fold_left min infinity arr in
      let max_v = Array.fold_left max neg_infinity arr in
      sprintf "%f,%f,%f,%f,%d,%d" mean sd min_v max_v n result
