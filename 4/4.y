%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
void yyerror();

struct quad {
    char op[5], a1[20], a2[20], res[20];
} q[100];

int i = 0, t = 0;

char* newtemp() {
    char *s = malloc(10);
    sprintf(s, "t%d", t++);
    return s;
}

char* emit(char *op, char *a1, char *a2) {
    char *tmp = newtemp();
    strcpy(q[i].op, op);
    strcpy(q[i].a1, a1);
    strcpy(q[i].a2, a2);
    strcpy(q[i].res, tmp);
    i++;
    return tmp;
}

void assign(char *l, char *r) {
    strcpy(q[i].op, "=");
    strcpy(q[i].a1, r);
    strcpy(q[i].res, l);
    i++;
}

void print() {
    int j;
    printf("\nThree Address Code:\n");
    for(j = 0; j < i; j++) {
        if(strcmp(q[j].op, "=") == 0)
            printf("%s = %s\n", q[j].res, q[j].a1);
        else
            printf("%s = %s %s %s\n", q[j].res, q[j].a1, q[j].op, q[j].a2);
    }
    printf("\nQuadruples:\n");
    printf("Index\tOp\tArg1\tArg2\tResult\n");
    for(j = 0; j < i; j++)
        printf("%d\t%s\t%s\t%s\t%s\n", j, q[j].op, q[j].a1, q[j].a2, q[j].res);
    printf("\nTriples:\n");
    printf("Index\tOp\tArg1\tArg2\n");
    for(j = 0; j < i; j++) {
        if(strcmp(q[j].op, "=") == 0)
            printf("%d\t=\t%s\t%s\n", j, q[j].a1, q[j].res);
        else
            printf("%d\t%s\t%s\t%s\n", j, q[j].op, q[j].a1, q[j].a2);
    }
}
%}

%union { char* text; }
%token <text> ID NUM
%type <text> expr term factor
%left '+' '-'
%left '*' '/'

%%
program : stmt_list { print(); };
stmt_list : stmt_list stmt | stmt;
stmt : ID '=' expr ';' { assign($1, $3); };
expr : expr '+' term { $$ = emit("+", $1, $3); }
     | expr '-' term { $$ = emit("-", $1, $3); }
     | term { $$ = $1; };
term : term '*' factor { $$ = emit("*", $1, $3); }
     | term '/' factor { $$ = emit("/", $1, $3); }
     | factor { $$ = $1; };
factor : '(' expr ')' { $$ = $2; }
       | ID { $$ = $1; }
       | NUM { $$ = $1; };
%%

void yyerror() {
    printf("Error in input\n");
}

int main() {
    printf("Enter expressions:\n");
    yyparse();
}

int yywrap() {
    return 1;
}