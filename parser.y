%{
#include <stdio.h>

int yylex(void);
void yyerror(char *);
%}

%token NUMBER

%%

lines   : lines line
        | /* NULL */
        ;

line    : expr '\n'         { printf(">> %d\n", $1); }
        | '\n'
        ;

expr    : term
        | '-' term          { $$ = -$2; }
        | expr '+' term     { $$ = $1 + $3; }
        | expr '-' term     { $$ = $1 - $3; }
        ;

term    : factor
        | term '*' factor   { $$ = $1 * $3; }
        | term '/' factor   { $$ = $1 / $3; }
        ;

factor  : '(' expr ')'      { $$ = $2; }
        | NUMBER
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
