{
  open Parser
  exception No_such_symbol
}

let space = [' ' '\t' '\n' '\r']
let digit = ['0'-'9']
let lower = ['a'-'z']
let upper = ['A'-'Z']
let id = lower ('_'|lower|upper|digit)*

rule token = parse
  | space+          { token lexbuf }
  | digit+ as num   { NUM (int_of_string num) }
  | "print"         { PRINT }
  | id as text      { ID text }
  | '='             { ASSIGN }
  | '+'             { ADD }
  | '-'             { SUB }
  | '*'             { MUL }
  | '/'             { DIV }
  | '('             { LP }
  | ')'             { RP }
  | '{'             { LB }
  | '}'             { RB }
  | ';'             { SEMI }
  | eof             { EOF }
  | _               { raise No_such_symbol }
