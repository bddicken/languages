open Printf

let read_lines path =
  let ic = open_in path in
  let buf = Buffer.create 1024 in
  let rec loop acc =
    try
      let line = input_line ic in
      Buffer.clear buf;
      Buffer.add_string buf line;
      loop (Buffer.contents buf :: acc)
    with End_of_file ->
      close_in ic; List.rev acc
  in
  loop []

let () =
  let args = Array.to_list Sys.argv |> List.tl in
  match args with
  | run_ms_str :: warmup_ms_str :: input_path :: _ ->
      let run_ms = int_of_string run_ms_str in
      let warmup_ms = int_of_string warmup_ms_str in
      let strings = Array.of_list (read_lines input_path) in
      let work () = Levenshtein.distances_sum strings in
      if warmup_ms > 0 then ignore (Benchmark.bench warmup_ms work);
      let result = Benchmark.bench run_ms work in
      print_endline (Benchmark.format_bench result)
  | _ ->
      eprintf "Usage: %s <run_ms> <warmup_ms> <input_path>\n" Sys.argv.(0);
      exit 1
