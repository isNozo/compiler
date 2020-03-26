let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    print_string (Emitter.trans_prog (Parser.prg Lexer.token lexbuf))
  with e -> raise e
