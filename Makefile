sim: optionM.ml ast.ml lexer.mll parser.mly emitter.ml sim.ml
# exec lex & yacc
	ocamllex lexer.mll
	ocamlyacc parser.mly
# generate cmi & cmo
	ocamlc -c optionM.ml
	ocamlc -c ast.ml
	ocamlc -c parser.mli
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	ocamlc -c emitter.ml
	ocamlc -c sim.ml
# generate target
	ocamlc -o sim \
               optionM.cmo \
               ast.cmo \
               lexer.cmo \
               parser.cmo \
               emitter.cmo \
               sim.cmo

clean:
	\rm -rf lexer.ml parser.ml *.mli *.cmi *.cmo sim
