type id  = string
type exp = ID of id
         | Num of int
         | Add of exp * exp
         | Sub of exp * exp
         | Mul of exp * exp
         | Div of exp * exp
and  stm = Stmts  of stm * stm
         | Assign of id * exp
         | Print  of exp
type env = id -> int option

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

let e0
    : env
  = fun _ ->
  None

let update
    : id -> int -> env -> env
  = fun var v env ->
  fun var' -> if (var' = var) then Some v else env var'

let rec trans_stm
    : stm -> env -> env option
  = fun stm env ->
  match stm with
  | Stmts  (s1, s2) -> trans_stm s1 env >>= fun env' ->
                       trans_stm s2 env'
  | Assign (var, e) -> trans_exp e env >>= fun v ->
                       return (update var v env)
  | Print  e        -> trans_exp e env >>= fun v ->
                       print_int v ;
                       print_string "\n" ;
                       return env

and trans_exp
    : exp -> env -> int option
  = fun exp env ->
  match exp with
  | ID  var      -> env var
  | Num n        -> return n
  | Add (e1, e2) -> trans_exp e1 env >>= fun v1 ->
                    trans_exp e2 env >>= fun v2 ->
                    return (v1 + v2)
  | Sub (e1, e2) -> trans_exp e1 env >>= fun v1 ->
                    trans_exp e2 env >>= fun v2 ->
                    return (v1 - v2)
  | Mul (e1, e2) -> trans_exp e1 env >>= fun v1 ->
                    trans_exp e2 env >>= fun v2 ->
                    return (v1 * v2)
  | Div (e1, e2) -> trans_exp e1 env >>= fun v1 ->
                    trans_exp e2 env >>= fun v2 ->
                    return (v1 / v2)

let interp
    : stm -> env option
  = fun stm ->
  trans_stm stm e0
