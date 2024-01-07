
open Graph

(* A path is a list of nodes. *)

type paths = id list


(*val residuel_graph :  int graph -> int graph *)

  

val find_route: int graph -> id list -> id -> id -> paths option

val max_flow_path: int graph -> int -> id -> id -> paths -> int

val modify_flow: int graph -> int -> id -> id -> paths -> int graph

val inter_residuel_graph  : int graph -> int graph -> string graph

val residuel_graph : int graph -> int graph






