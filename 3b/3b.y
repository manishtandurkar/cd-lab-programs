%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
void yyerror();
%}

%token TYP ID LP RP LB RB SC CM EQ RETURN NUM
%right EQ
%left '+' '-'
%left '*' '/'

%%
prog: func;
func: TYP ID LP params RP LB stmts RB { printf("Valid Function\n"); };
params
    : paramlist
    |
    ;
paramlist
    : param
    | paramlist CM param
    ;
param
    : TYP ID
    ;
stmts
    :
    | stmts stmt
    ;
stmt
    : TYP ID SC
    | TYP ID EQ expr SC
    | expr SC
    | RETURN expr SC
    ;
expr
    : ID
    | NUM
    | ID EQ expr
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | LP expr RP
    ;
%%

int main() {
    printf("Enter function:\n");
    yyparse();
    exit(0);
}

void yyerror() {
    printf("Invalid Function\n");
    exit(0);
}

int yywrap() {
    return 1;
}