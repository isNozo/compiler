type id = string
type exp = ID of id
         | Num of int
         | Add of exp * exp
         | Sub of exp * exp
         | Mul of exp * exp
         | Div of exp * exp
and  stm = Stmts of stm * stm
         | Assign of id * exp
         | Print of exp

let e0
    : id -> int option
  = fun _ ->
  None

let update
    : id -> int -> (id -> int option) -> (id -> int option)
  = fun var vl env ->
  fun v -> if (v = var) then Some vl else env v

let rec trans_stm
    : stm -> (id -> int option) -> (id -> int option) option
  = fun stm env ->
  match stm with
  | Stmts  (s1, s2) -> (match trans_stm s1 env with
                        | Some env' -> trans_stm s2 env'
                        | None -> None
                       )
  | Assign (var, e) -> (match trans_exp e env with
                        | Some v -> Some (update var v env)
                        | None -> None
                       )
  | Print  e        -> (match trans_exp e env with
                        | Some v -> print_int v; print_string "\n"; Some env
                        | None -> None
                       )

and trans_exp
    : exp -> (id -> int option) -> int option
  = fun exp env ->
  match exp with
  | ID  var      -> env var
  | Num n        -> Some n
  | Add (e1, e2) -> (match (trans_exp e1 env, trans_exp e2 env) with
                     | Some v1, Some v2 -> Some (v1 + v2)
                     | _, _ -> None
                    )
  | Sub (e1, e2) -> (match (trans_exp e1 env, trans_exp e2 env) with
                     | Some v1, Some v2 -> Some (v1 - v2)
                     | _, _ -> None
                    )
  | Mul (e1, e2) -> (match (trans_exp e1 env, trans_exp e2 env) with
                     | Some v1, Some v2 -> Some (v1 * v2)
                     | _, _ -> None
                    )
  | Div (e1, e2) -> (match (trans_exp e1 env, trans_exp e2 env) with
                     | Some v1, Some v2 -> Some (v1 / v2)
                     | _, _ -> None
                    )

let interp
    : stm -> (id -> int option) option
  = fun stm ->
  trans_stm stm e0
                      
let prog 
    : stm
  = Stmts (Assign ("x", Add (Num 1, Mul (Num 2, Num 3))),
           Stmts (Assign ("y", Div (ID "x", Num 4)), Print (ID "y")))
