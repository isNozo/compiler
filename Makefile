calc: lexer.mll parser.mly calc.ml
# exec lex & yacc
	ocamllex lexer.mll
	ocamlyacc parser.mly
# generate cmi
	ocamlc -c parser.mli
# generate cmo
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	ocamlc -c calc.ml
# generate target
	ocamlc -o calc lexer.cmo parser.cmo calc.cmo

clean:
	\rm -rf lexer.ml parser.ml *.mli *.cmi *.cmo calc
