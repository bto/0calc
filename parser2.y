%{
#include <stdio.h>

int yylex(void);
void yyerror(char *);
%}

%token NUMBER

%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%

lines   : lines line
        | /* NULL */
        ;

line    : expr '\n'         { printf(">> %d\n", $1); }
        | '\n'
        ;

expr    : NUMBER
        | '-' expr %prec UMINUS   { $$ = -$2; }
        | expr '+' expr         { $$ = $1 + $3; }
        | expr '-' expr         { $$ = $1 - $3; }
        | expr '*' expr         { $$ = $1 * $3; }
        | expr '/' expr         { $$ = $1 / $3; }
        | '(' expr ')'          { $$ = $2; }
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
