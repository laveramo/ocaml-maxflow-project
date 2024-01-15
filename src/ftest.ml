open Gfile
open Ford_Fulkerson
open Tools
open Money_sharing

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
 (* For testing just the algorithm *)
 (*let graph2 = ford_fulkerson (gmap graph  (fun x -> int_of_string x)) _source _sink  in *)

 (* For solving money sharing problem *)

 let personnes = nodes [0;1;2]  in 
 let personnes_graph = all personnes [0;1;2]  in
 let graph_to_solve = final_graph personnes_graph [(0,40);(1,-20);(2,-20)]  in 
 let graph2 = ford_fulkerson  graph_to_solve 2000 1000 in 

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph2 in
    export "graph_infile" graph;
    export "graph_money_sharing" (gmap graph_to_solve (fun x -> string_of_int x));
    export "answer" graph2;
  ()