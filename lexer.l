%{
#include "parser.h"
extern int yylval;
%}

%%

[0-9]+          {
                    yylval = atoi(yytext);
                    return NUMBER;
                }


[-+*/()=\n]     {
                    return *yytext;
                }

[ \t]+          ;   /* ignore whitespace */

%%

int
yywrap()
{
    return 1;
}
