%{
#include<stdio.h>
int posint = 0, negint = 0, posfrac = 0, negfrac = 0, invalid = 0;
%}

NUM        [0-9]+
POSINT     {NUM}
NEGINT     -{NUM}
POSFRAC    {NUM}\.{NUM}|\.[0-9]+|{NUM}\/{NUM}
NEGFRAC    -{POSFRAC}

%%
{NEGFRAC}   { negfrac++; }
{POSFRAC}   { posfrac++; }
{NEGINT}    { negint++; }
{POSINT}    { posint++; }
[ \t\n]+    ;
.           { invalid++; }
%%

int main() {
    printf("Enter input (Press Ctrl+D to end input):\n");
    yylex();
    printf("Positive integers: %d\n", posint);
    printf("Negative integers: %d\n", negint);
    printf("Positive fractions: %d\n", posfrac);
    printf("Negative fractions: %d\n", negfrac);
    printf("Invalid inputs: %d\n", invalid);
}

int yywrap() {
    return 1;
}