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


