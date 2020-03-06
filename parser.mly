%token<int> NUM
%token ADD SUB MUL DIV LP RP EOL

%left ADD SUB
%left MUL DIV
%nonassoc MINUS

%start prog
%type <int> prog

%%
prog: expr EOL             { $1 }
    ;

expr: NUM                  { $1 }
    | LP expr RP           { $2 }
    | expr ADD expr        { $1 + $3 }
    | expr SUB expr        { $1 - $3 }
    | expr MUL expr        { $1 * $3 }
    | expr DIV expr        { $1 / $3 }
    | SUB expr %prec MINUS { -$2 }
    ;
