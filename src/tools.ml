open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = n_fold gr new_node empty_graph
let gmap gr f = 
  let graph_nodes = clone_nodes gr in
  e_fold gr (fun g arc -> new_arc g {arc with lbl = f arc.lbl} ) graph_nodes

let add_arc g id1 id2 n =
  let arc_found = find_arc g id1 id2 in
  match arc_found with
  | Some arc -> new_arc g {src = id1; tgt = id2; lbl = arc.lbl + n}
  | None -> new_arc g {src = id1; tgt = id2; lbl = n}