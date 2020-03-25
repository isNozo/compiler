%token <int> NUM
%token <string> ID
%token ADD SUB MUL DIV ASSIGN PRINT LP RP SEMI EOF

%right SEMI
%left ADD SUB
%left MUL DIV

%start prg
%type <Ast.stm> prg

%%

prg:
  | stm                  { $1 }
  ;

stm:
  | stm SEMI stm         { Ast.Stmts  ($1, $3) }
  | ID ASSIGN exp        { Ast.Assign ($1, $3) }
  | PRINT exp            { Ast.Print  ($2) }
  ;

exp:
  | ID                   { Ast.ID  $1 }
  | NUM                  { Ast.Num $1 }
  | LP exp RP            { $2 }
  | exp ADD exp          { Ast.Add ($1, $3) }
  | exp SUB exp          { Ast.Sub ($1, $3) }
  | exp MUL exp          { Ast.Mul ($1, $3) }
  | exp DIV exp          { Ast.Div ($1, $3) }
  ;
