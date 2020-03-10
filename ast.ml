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
