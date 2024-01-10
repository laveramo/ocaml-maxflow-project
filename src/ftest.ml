open Gfile
open Tools
open Ford_Fulkerson
let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in
  


  (* Open file *)
  let graph = from_file infile in
(*
  let testy = find_route (gmap graph (fun x -> int_of_string x + 2)) [] 1 12 in
  let max = max_flow_path (gmap graph (fun x -> int_of_string x + 2)) 600 1 12 (Option.get testy) in
Printf.printf "max flow of this path is  : %d\n" max;
match testy with
| Some path ->
  Printf.printf "Path found: ";
  List.iter (fun node -> Printf.printf "%d -> " node) path;
  Printf.printf "End\n"
| None ->
  Printf.printf "No path found.\n";*)


let graph2 = ford_fulkerson (gmap graph  (fun x -> int_of_string x)) 0 5 in

(*let graph2 = gmap (residuel_graph (gmap graph (fun x -> int_of_string x))) (fun x -> string_of_int x)  in *)
       
  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph2 in
    export "outfiletest" graph;
    export "outfiletest2" graph2;
  ()

