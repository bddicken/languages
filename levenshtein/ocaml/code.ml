(* Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
   Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
   Time Complexity: O(m*n) where m and n are the lengths of the input strings *)
let levenshtein_distance s1 s2 =
  (* Early termination checks *)
  if s1 = s2 then 0
  else if String.length s1 = 0 then String.length s2
  else if String.length s2 = 0 then String.length s1
  else
    (* Make s1 the shorter string for space optimization *)
    let (s1, s2) =
      if String.length s1 > String.length s2
      then (s2, s1)
      else (s1, s2)
    in
    
    let m = String.length s1 in
    let n = String.length s2 in

    (* Use two arrays instead of full matrix for space optimization *)
    let prev_row = Array.init (m + 1) (fun i -> i) in
    let curr_row = Array.make (m + 1) 0 in

    (* Main computation loop *)
    for j = 1 to n do
      curr_row.(0) <- j;

      for i = 1 to m do
        let cost = if s1.[i-1] = s2.[j-1] then 0 else 1 in
        
        (* Calculate minimum of three operations *)
        curr_row.(i) <- min
          (min
            (prev_row.(i) + 1)      (* deletion *)
            (curr_row.(i-1) + 1)    (* insertion *)
          )
          (prev_row.(i-1) + cost)   (* substitution *)
      done;

      (* Copy current row to previous row *)
      Array.blit curr_row 0 prev_row 0 (m + 1)
    done;

    prev_row.(m)

(* Main program *)
let () =
  let args = Array.to_list (Array.sub Sys.argv 1 (Array.length Sys.argv - 1)) in
  
  if List.length args < 2 then begin
    Printf.printf "Please provide at least two strings as arguments.\n";
    exit 1
  end;

  let min_distance = ref (-1) in
  let times = ref 0 in

  (* Compare all pairs of strings *)
  List.iteri (fun i str1 ->
    List.iteri (fun j str2 ->
      if i <> j then begin
        let distance = levenshtein_distance str1 str2 in
        if !min_distance = -1 || distance < !min_distance then
          min_distance := distance;
        incr times
      end
    ) args
  ) args;

  Printf.printf "times: %d\n" !times;
  Printf.printf "min_distance: %d\n" !min_distance
