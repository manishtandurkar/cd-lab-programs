%{
#include<stdio.h>
int l = 0, w = 0, s = 0, c = 0;
%}

%%
\n              { l++; c++; }
[ ]             { s++; c++; }
\t              { s++; c++; }
[a-zA-Z0-9]+    { w++; c += yyleng; }
.               { c++; }
%%

int main() {
    printf("Enter a paragraph (Press Ctrl+D to end input):\n");
    yylex();
    printf("\nCount Summary:\n");
    printf("Lines: %d\n", l);
    printf("Words: %d\n", w);
    printf("Spaces: %d\n", s);
    printf("Characters: %d\n", c);
}