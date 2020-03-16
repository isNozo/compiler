let (>>=)
    : 'a option -> ('a -> 'b option) -> 'b option
  = fun v f ->
  match v with
  | None   -> None
  | Some x -> f x

let return
    : 'a -> 'a option
  = fun v ->
  Some v
