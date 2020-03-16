open Printf
open Ast

let rec trans_stm
    : stm -> string
  = fun stm ->
  match stm with
  | Stmts  (s1, s2) -> ""
  | Assign (var, e) -> ""
  | Print  e        -> ""

and trans_exp
    : exp -> string
  = fun exp ->
  match exp with
  | ID  var      -> ""
  | Num n        -> (sprintf "\tpushq $%d\n" n)
  | Add (e1, e2) -> trans_exp e1 ^
                    trans_exp e2 ^
                    "\tpopq %rax\n" ^
                    "\taddq %rax, (%rsp)\n"
  | Sub (e1, e2) -> trans_exp e1 ^
                    trans_exp e2 ^
                    "\tpopq %rax\n" ^
                    "\tsubq %rax, (%rsp)\n"
  | Mul (e1, e2) -> ""
  | Div (e1, e2) -> ""

let trans_prog
    : exp -> string
  = fun exp ->
  trans_exp exp
