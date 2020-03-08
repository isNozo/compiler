%token<int> NUM
%token<string> ID
%token ADD SUB MUL DIV ASSIGN PRINT LP RP SEMI EOL

%right SEMI
%left ADD SUB
%left MUL DIV

%start parse
%type <Interp.stm> parse

%%

parse:
  |stm EOL              { $1 }
  ;

stm:
  | stm SEMI stm         { Interp.Stmts  ($1, $3) }
  | ID ASSIGN exp        { Interp.Assign ($1, $3) }
  | PRINT exp            { Interp.Print  ($2) }
  ;

exp:
  | ID                   { Interp.ID  $1 }
  | NUM                  { Interp.Num $1 }
  | LP exp RP            { $2 }
  | exp ADD exp          { Interp.Add ($1, $3) }
  | exp SUB exp          { Interp.Sub ($1, $3) }
  | exp MUL exp          { Interp.Mul ($1, $3) }
  | exp DIV exp          { Interp.Div ($1, $3) }
  ;
