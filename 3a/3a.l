%{
#include "y.tab.h"
%}

%%
"for"        { return FOR; }
"("          { return '('; }
")"          { return ')'; }
"{"          { return '{'; }
"}"          { return '}'; }
"=="         { return EQ; }
"<="         { return LE; }
">="         { return GE; }
"++"         { return INC; }
"--"         { return DEC; }
"="          { return '='; }
"<"          { return '<'; }
">"          { return '>'; }
";"          { return ';'; }
[a-zA-Z]+    { return ID; }
[0-9]+       { return NUM; }
[ \t\n]      ;
.            ;
%%

int yywrap() {
    return 1;
}