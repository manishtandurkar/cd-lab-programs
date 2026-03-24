%{
#include<stdio.h>
int v = 0, c = 0;
%}

%%
[aeiouAEIOU] { v++; }
[a-zA-Z] { c++; }
\n return 0;
%%

int main() {
    printf("Enter a word: ");
    yylex();
    printf("Number of vowels: %d\n", v);
    printf("Number of consonants: %d\n", c);
}