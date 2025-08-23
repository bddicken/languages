open Printf

let () =
  let args = Array.to_list Sys.argv |> List.tl in
  match args with
  | run_ms_str :: warmup_ms_str :: u_str :: _ ->
      let run_ms = int_of_string run_ms_str in
      let warmup_ms = int_of_string warmup_ms_str in
      let u = int_of_string u_str in
      let work () = Loops.loops u in
      if warmup_ms > 0 then ignore (Benchmark.bench warmup_ms work);
      let result = Benchmark.bench run_ms work in
      print_endline (Benchmark.format_bench result)
  | _ ->
      eprintf "Usage: %s <run_ms> <warmup_ms> <u>\n" Sys.argv.(0);
      exit 1
