%{
#include<stdio.h>
#include<stdlib.h>
void yyerror();
int yylex();
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%
S : E { printf("Result is %d\n", $1); }
  ;
E : E '+' E { $$ = $1 + $3; }
  | E '-' E { $$ = $1 - $3; }
  | E '*' E { $$ = $1 * $3; }
  | E '/' E { if($3 == 0) yyerror(); else $$ = $1 / $3; }
  | '(' E ')' { $$ = $2; }
  | NUM       { $$ = $1; }
  | '-' NUM   { $$ = -$2; }
  ;
%%

int main() {
    printf("Enter an expression:\n");
    yyparse();
}

void yyerror() {
    printf("Invalid expression\n");
    exit(0);
}

int yywrap() {
    return 1;
}