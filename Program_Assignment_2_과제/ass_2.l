%{
#include "y.tab.h"
#include <stdlib.h>
void yyerror(char *);
%}
number [0-9]+(\.[0-9]+)?(E[+\-]?[0-9]+)?
%%
{number} {yylval.vd = atof(yytext); return NUMBER; }
[-+()=/*\n;] { return *yytext; }
[ \t] ;
%%
int yywrap(){
	return 1;
}

