%{
open Ast
%}

%token <int> NUM
%token <string> ID
%token PRINT INT ASSIGN ADD SUB MUL DIV LP RP LB RB SEMI EOF

%right SEMI
%left ADD SUB
%left MUL DIV

%start prg
%type <Ast.stm> prg

%%

prg:
  | stm                  { $1 }
  ;

typ:
  | INT                  { IntTyp }
  ;

decs:
  | decs dec             { $1 @ [$2] }
  |                      { [] }
  ;

dec:
  | typ ID SEMI          { VarDec ($1, $2) }
  ;

stms:
  | stms stm             { $1 @ [$2] }
  | stm                  { [$1] }
  ;

stm:
  | LB decs stms RB      { Block ($2, $3) }
  | ID ASSIGN exp SEMI   { Assign ($1, $3) }
  | PRINT exp SEMI       { Print $2 }
  ;

exp:
  | ID                   { VarExp $1 }
  | NUM                  { IntExp $1 }
  | LP exp RP            { $2 }
  | exp ADD exp          { Add ($1, $3) }
  | exp SUB exp          { Sub ($1, $3) }
  | exp MUL exp          { Mul ($1, $3) }
  | exp DIV exp          { Div ($1, $3) }
  ;
