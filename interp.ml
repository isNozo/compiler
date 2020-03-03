type id = string
type stm = Stmts of stm * stm
         | Assign of id * exp
         | Print of exp
and  exp = ID of id
         | Num of int
         | Add of exp * exp
         | Sub of exp * exp
         | Mul of exp * exp
         | Div of exp * exp

let e0
    : id -> exp option
  = fun _ ->
  None

let update
    : id -> exp -> (id -> exp option) -> (id -> exp option)
  = fun var vl env ->
  fun v -> if (v = var) then Some vl else env v

let trans_stm
    : stm -> exp option
  = fun stm ->
  match stm with
  | Stmts  (s1, s2) -> None
  | Assign (var, e) -> None
  | Print  e        -> None

let trans_exp
    : exp -> (id -> exp option) -> exp option 
  = fun exp env ->
  match exp with
  | ID  var      -> env var
  | Num n        -> None
  | Add (e1, e2) -> None
  | Sub (e1, e2) -> None
  | Mul (e1, e2) -> None
  | Div (e1, e2) -> None

let prog 
    : stm
  = Stmts (Assign ("x", Add (Num 1, Mul (Num 2, Num 3))),
           Stmts (Assign ("y", Div (ID "x", Num 4)), Print (ID "y")))
