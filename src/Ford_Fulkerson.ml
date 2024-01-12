open Graph
open Tools


type paths = id list


let rec find_route gr visited id1 id2 =
  if id1 = id2 then Some []
  else
    let out_arcs_node = out_arcs gr id1 in

    let rec is_visited x = function
      | [] -> false
      | a :: _ when x = a -> true
      | _ :: rest -> is_visited x rest
    in

    let rec arcs_route = function
      | [] -> []
      | { src = _; tgt = dst; lbl = vl } :: rest ->
          if is_visited dst visited || vl <= 0 then arcs_route rest
          else dst :: arcs_route rest
    in

    match arcs_route out_arcs_node with
    | [] -> None
    | x :: _ ->
        match find_route gr visited x id2 with
        | None -> find_route gr (x :: visited) id1 id2
        | Some liste -> Some (x :: liste)
;;

let find_route2  gr visited id1 id2= 
match(find_route gr visited id1 id2) with 
|None -> None 
|Some l -> Some (id1::l) 
;;


let residuel_graph gr = 
  let empty_graph = clone_nodes gr in 
  let f gr1 {src =id1 ; tgt = id2 ; lbl = n} = new_arc (new_arc gr1 {src =id2 ; tgt = id1 ; lbl = 0}) {src =id1; tgt =id2 ; lbl = n} in
  e_fold gr f empty_graph
;;

let rec max_flow_path gr max  = function
  | [] -> max
  |_::[]->max
  | nd1 ::nd2:: rest ->
    match find_arc gr nd1 nd2 with
    | None -> 0
    | Some arc -> max_flow_path gr (min max arc.lbl)  (nd2::rest)
;;

(*c'est bon*)
let rec modify_flow gr n = function
  |[] -> gr
  |_ :: [] -> gr
  |nd1 :: nd2 :: rest -> modify_flow (add_arc (add_arc gr nd1 nd2 (-n)) nd2 nd1 n) n (nd2::rest)
;;

let inter_residuel_graph graph resd_graph =
    let new_graph = clone_nodes graph in
    let f empty_graph arc =
      let v = match find_arc resd_graph arc.tgt arc.src with
        | None -> raise (Failure "Error")
        | Some x -> x
      in
      new_arc empty_graph {src = arc.src; tgt = arc.tgt; lbl = Printf.sprintf "%d/%d" v.lbl arc.lbl} in
    e_fold graph f new_graph 
;;
  
let ford_fulkerson graph id1 id2 =
    let residual_graph = residuel_graph graph in
    let rec loop l_graph id1 id2 =
      let max = 500 in
      let visited = [] in
      let path = find_route2 l_graph visited id1 id2 in
      match path with
      | None -> l_graph
      | Some list ->
        let flow = max_flow_path l_graph max list in
        let modified_resid_graph = modify_flow l_graph flow list in
        loop modified_resid_graph id1 id2
    in
    loop residual_graph id1 id2
;;
  
  











  
  
 



