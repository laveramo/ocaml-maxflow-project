open Graph


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

let rec max_flow_path gr max id1 id2 = function
  | [] -> max
  | nd :: rest ->
    match find_arc gr id1 nd with
    | None -> 0
    | Some arc -> max_flow_path gr (min max arc.lbl) nd id2 rest
;;


