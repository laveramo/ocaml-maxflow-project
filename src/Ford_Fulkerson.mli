
open Graph

(* A path is a list of nodes. *)

type paths = id list


(*val residuel_graph :  int graph -> int graph *)

  

val find_route: int graph -> int  list -> id -> id -> paths option

val find_route2: int graph -> int  list -> id -> id -> paths option

val max_flow_path: int graph -> int -> paths -> int

val modify_flow: int graph -> int -> paths -> int graph

val inter_residuel_graph  : int graph -> int graph -> string graph 

val residuel_graph : int graph -> int graph

val ford_fulkerson : int graph -> id -> id -> string graph 






