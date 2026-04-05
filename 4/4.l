%{
#include <stdio.h>
int single = 0, multi = 0;
%}

%%
\/\/[^\n]*                   { single++; }
\/\*([^*]|\*+[^*/])*\*+\/    { multi++; }
[ \t\n]+                ;
.                       ;
%%

int main(int argc, char *argv[]) {
    if(argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }
    FILE *fp = fopen(argv[1], "r");
    if(!fp) {
        printf("Cannot open file\n");
        return 1;
    }
    yyin = fp;
    yylex();
    printf("Single line comments: %d\n", single);
    printf("Multi line comments: %d\n", multi);
    fclose(fp);
}