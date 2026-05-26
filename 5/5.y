%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
void yyerror();

int reg = 0;

char* newReg() {
    char *r = (char*)malloc(10);
    sprintf(r, "R%d", reg++);
    return r;
}
%}

%union
{
    char *str;
}
%token <str> ID NUM
%type <str> expr
%left '+'
%left '*'

%%
stmt
    : ID '=' expr ';' { printf("MOV %s, %s\n", $1, $3); };
expr
    : expr '+' expr { char *r = newReg(); printf("MOV %s, %s\n", r, $1); printf("ADD %s, %s\n", r, $3); $$ = r; }
    | expr '*' expr { char *r = newReg(); printf("MOV %s, %s\n", r, $1); printf("MUL %s, %s\n", r, $3); $$ = r; }
    | ID { $$ = $1; }
    | NUM { $$ = $1; };
%%

void yyerror() {
    printf("Error\n");
}

int main() {
    yyparse();
}

int yywrap() {
    return 1;
}