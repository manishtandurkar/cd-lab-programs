%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
void yyerror();
%}

%%
S:A B
 ;
A:'a' A 'b'
 |
 ;
B:'b' B 'c'
 |
 ;
%%

void yyerror() {
    printf("Invalid string\n");
}

int main() {
    printf("Enter string: \n");
    yyparse();
    printf("Valid string\n");
    return 0;
}

int yywrap() {
    return 1;
}