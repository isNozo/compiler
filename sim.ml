let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    print_string (Emitter.trans_prog (Parser.prg Lexer.token lexbuf))
  with
  | Lexer.No_such_symbol -> print_string "No_such_symbol\n"
  | _                    -> print_string "some error\n"
