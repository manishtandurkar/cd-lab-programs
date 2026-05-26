%{
#include "y.tab.h"
%}

%%
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.text = strdup(yytext); return ID; }
[0-9]+                  { yylval.text = strdup(yytext); return NUM; }
[ \t\r\n]+              ;
.                       { return yytext[0]; }
%%