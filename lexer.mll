{
  open Parser
  exception Eof
}

let id = ['a'-'z'] ['a'-'z' '0'-'9']*

rule token = parse
  | ['0'-'9']+ as v { NUM (int_of_string(v)) }
  | "print"         { PRINT }
  | id as str       { ID str }
  | '='             { ASSIGN }
  | '+'             { ADD }
  | '-'             { SUB }
  | '*'             { MUL }
  | '/'             { DIV }
  | '('             { LP }
  | ')'             { RP }
  | ';'             { SEMI }
  | [' ' '\t']      { token lexbuf }
  | ['\n']          { EOL }
  | eof             { raise Eof }
