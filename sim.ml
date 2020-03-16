let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    while true do
      let ast = Parser.parse Lexer.token lexbuf in
      let asm = Emitter.trans_prog ast in
      print_string asm
    done
  with Lexer.Eof -> exit 0
