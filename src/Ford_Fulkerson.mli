
open Graph

(* A path is a list of nodes. *)

type paths = id list


(*val residuel_graph :  int graph -> int graph *)

val find_route: int graph -> id list -> id -> id -> paths option


