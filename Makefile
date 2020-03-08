calc: lexer.mll parser.mly calc.ml
# exec lex & yacc
	ocamllex lexer.mll
	ocamlyacc parser.mly
# generate cmi & cmo
	ocamlc -c interp.ml
	ocamlc -c parser.mli
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	ocamlc -c calc.ml
# generate target
	ocamlc -o calc interp.cmo lexer.cmo parser.cmo calc.cmo

clean:
	\rm -rf lexer.ml parser.ml *.mli *.cmi *.cmo calc
