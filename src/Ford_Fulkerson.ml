open Graph
open Tools
open Gfile

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

let find_route2  gr id1 id2= 
match(find_route gr [] id1 id2) with 
|None -> None 
|Some l -> Some (id1::l) 
;;


let residuel_graph gr = 
  let empty_graph = clone_nodes gr in 
  let f gr1 {src =id1 ; tgt = id2 ; lbl = n} = new_arc (new_arc gr1 {src =id2 ; tgt = id1 ; lbl = 0}) {src =id1; tgt =id2 ; lbl = n} in
  e_fold gr f empty_graph
;;

let rec max_flow_path gr max id1 id2 = function
  | [] -> max
  | nd :: rest ->
    match find_arc gr id1 nd with
    | None -> 0
    | Some arc -> max_flow_path gr (min max arc.lbl) nd id2 rest
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
    let res_graph = residuel_graph graph in
    let maxs = 500 in
  
    let rec loop res_graph id1 id2 = 
      let path = find_route2 graph id1 id2 in
      match path with
      | None -> 
        export "outfilexport3" (gmap res_graph (fun x -> string_of_int x));
        inter_residuel_graph graph res_graph
      | Some list -> 
        let flow = max_flow_path res_graph maxs id1 id2 list in  
        let modified_graph = modify_flow res_graph flow  list in
        loop modified_graph id1 id2
    in
  
    loop res_graph id1 id2
   
;;



