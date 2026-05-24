%{
#include<stdio.h>
int lines = 1, spaces = 0, words = 0, characters = 0;
%}

%%
[ ]       {spaces++;}
[\t]      {spaces=spaces+3;}
[\n]      {lines++;}
[a-zA-Z]* {words++; characters=characters+yyleng;}
#         {return 0;}
%%

int yywrap() {
    return 1;
}

int main(){
    printf("Enter a paragraph (use # to end):\n");
    yylex();
    printf("Lines: %d\nSpaces: %d\nWords: %d\nCharacters: %d\n", lines, spaces, words, characters);
}