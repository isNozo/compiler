open Printf
open Ast

let rec trans_stm
    : stm -> string
  = fun stm ->
  match stm with
  | Stmts  (s1, s2) -> ""
  | Assign (var, e) -> ""
  | Print  e        -> trans_exp e ^
                       "\tpopq %rsi\n" ^
                       "\tleaq IO(%rip), %rdi\n" ^
                       "\tmovq $0, %rax\n" ^
                       "\tcallq printf@PLT\n"

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

let header
    : string
  = "\
     IO:
     \t.string \"%lld\\n\"
     \t.text\n\
     \t.global main\n\
     main:\n\
    "

let prologue
    : string
  = "\
     \tpushq %rbp\n\
     \tmovq %rsp, %rbp\n\
    "

let epilogue
    : string
  = "\
     \tleaveq\n\
     \tretq\n\
    "

let trans_prog
    : stm -> string
  = fun stm ->
  header ^ prologue ^ (trans_stm stm) ^ epilogue
