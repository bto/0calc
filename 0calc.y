%{
#include <stdio.h>

int yylex(void);
void yyerror(char *);
%}

%token NUMBER

%%

lines   : line
        | lines line
        ;

line    : expr '\n'     { printf(">> %d\n", $1); }
        ;

expr    : term
        | expr '+' expr { $$ = $1 + $3; }
        | expr '-' expr { $$ = $1 - $3; }
        ;

term    : factor        { $$ = $1; }
        | term '*' term { $$ = $1 * $3; }
        | term '/' term { $$ = $1 / $3; }
        ;

factor  : '(' expr ')'  { $$ = $2; }
        | number        { $$ = $1; }
        ;

number  : NUMBER
        | '-' NUMBER
        ;
%%

void
yyerror(char *s)
{
    fprintf(stdout, "%s\n", s);
}

int
main(void)
{
    yyparse();
    return 0;
}
