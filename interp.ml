type id = string
type stm = Stems of stm * stm
         | Assign of id * exp
         | Print of exp
and  exp = ID of id
         | Num of int
         | Add of exp * exp
         | Sub of exp * exp
         | Mul of exp * exp
         | Div of exp * exp

let e0 = fun _ -> None
let update var vl env = fun v -> if (v = var) then vl else env v

let trans_exp exp env =
  match exp with
      ID  var      -> env var
    | Num n        -> Some n
    | Add (e1, e2) -> None
    | Sub (e1, e2) -> None
    | Mul (e1, e2) -> None
    | Div (e1, e2) -> None
