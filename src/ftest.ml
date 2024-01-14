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
  

 (* let graph2 = gmap (modify_flow (gmap graph (fun x -> int_of_string x)) 3 (Option.get testy) ) (fun x -> string_of_int x)  in*)
  


  (* Open file *)
  
  (*let testy = find_route2 (gmap graph (fun x -> int_of_string x )) [] 0 5 in
  match testy with
| Some path ->
  Printf.printf "Path found: ";
  List.iter (fun node -> Printf.printf "%d -> " node) path;
  Printf.printf "End\n"
| None ->
  Printf.printf "No path found.\n";*)
 (* let graph2 = gmap (modify_flow (gmap graph (fun x -> int_of_string x)) 3 (Option.get testy) ) (fun x -> string_of_int x)  in*)
 let graph_in = from_file infile in
 let graph_out = gmap (ford_fulkerson (gmap graph_in  (fun x -> int_of_string x)) 0 10) (fun x -> string_of_int x)  in     
  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph_out in
    export "outfiletest" graph_in;
    export "outfiletest2" graph_out;
  ()

