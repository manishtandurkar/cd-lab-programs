%{
#include "y.tab.h"
%}

%%
"int"|"void"|"char"|"float"|"double" { return TYP; }
"return" { return RETURN; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
"(" { return LP; }
")" { return RP; }
"{" { return LB; }
"}" { return RB; }
";" { return SC; }
"," { return CM; }
"=" { return EQ; }
"+" { return '+'; }
"-" { return '-'; }
"*" { return '*'; }
"/" { return '/'; }
[0-9]+ { return NUM; }
[ \t\n] ;
. ;
%%