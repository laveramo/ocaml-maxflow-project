open Graph
open Tools


let nodes liste  = 
let gr = empty_graph in
let rec loop graph l =
  match l with 
  |[] -> graph
  |x::rest -> loop (new_node graph x) rest in
  loop gr liste ;;



  let all gr liste =
    let rec connect_nodes graph id lst =
      match lst with 
      | [] -> graph
      | tgt_id :: rest ->
        let new_graph = add_arc graph id tgt_id 100 in
        let reversed_graph = add_arc new_graph tgt_id id 100 in
        connect_nodes reversed_graph id rest
    in
    let rec connect_all_nodes graph lst =
      match lst with
      | [] -> graph
      | id :: rest ->
        let updated_graph = connect_nodes graph id rest in
        connect_all_nodes updated_graph rest
    in
    match liste with
    | [] -> gr
    | id :: rest -> connect_all_nodes gr (id :: rest)
  ;;
  

let  final_graph gr l = 
  let graph2 = new_node (new_node gr (2000)) 1000 in
  let rec loop graph liste =  
    match liste with 
    |[]->graph
    |(id,cd)::rest -> if cd <= 0 then loop (new_arc graph {src=(2000)  ; tgt = id ; lbl = (-cd)}) rest else loop (new_arc  graph {src= id  ; tgt = 1000 ; lbl = cd}) rest in
    loop graph2 l 
  ;;
  
  
