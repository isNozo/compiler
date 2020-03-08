let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    while true do
      let ast = Parser.parse Lexer.token lexbuf in
      let _ = Interp.interp ast in
      flush stdout
    done
  with Lexer.Eof -> exit 0
