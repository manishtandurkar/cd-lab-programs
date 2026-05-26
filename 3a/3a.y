%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
void yyerror();
int count = 0;
%}

%token FOR ID NUM EQ LE GE INC DEC

%%
S : FORLOOP { printf("Valid\n"); printf("Number of FOR loops = %d\n", count); };
FORLOOP : FOR '(' INIT ';' COND ';' UPDATE ')' BLOCK { count++; };
INIT  : ID_LIST '=' NUM ;
ID_LIST : ID | ID_LIST ID ;
COND
    : ID '<' NUM
    | ID '>' NUM
    | ID LE NUM
    | ID GE NUM
    | ID EQ NUM
    | ID '<' ID
    | ID '>' ID
    | ID LE ID
    | ID GE ID
    | ID EQ ID
    ;
UPDATE
    : ID INC
    | ID DEC
    ;
BLOCK
    : '{' BODY '}'
    ;
BODY
    : FORLOOP BODY
    |
    ;
%%

int main() {
    printf("Enter code:\n");
    yyparse();
}

void yyerror() {
    printf("Invalid\n");
    exit(0);
}

int yywrap() {
    return 1;
}