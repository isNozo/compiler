{
  open Parser
  exception Eof
}

rule token = parse
  | ['0'-'9']+ as v { NUM (int_of_string(v)) }
  | '+'             { ADD }
  | '-'             { SUB }
  | '*'             { MUL }
  | '/'             { DIV }
  | '('             { LP }
  | ')'             { RP }
  | [' ' '\t']      { token lexbuf }
  | ['\n']          { EOL }
  | eof             { raise Eof }
