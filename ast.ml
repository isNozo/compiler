type id  = string
type exp = VarExp of id
         | IntExp of int
         | Add of exp * exp
         | Sub of exp * exp
         | Mul of exp * exp
         | Div of exp * exp
and  stm = Block  of (dec list) * (stm list)
         | Assign of id * exp
         | Print  of exp
and  dec = VarDec of typ * id
and  typ = IntTyp
