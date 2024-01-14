open Graph

val nodes : id list -> 'a graph

val all : int graph -> int list ->  int graph
val final_graph : int graph -> (id * int) list -> int graph
