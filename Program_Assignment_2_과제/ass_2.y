%{
#include <stdio.h>
#include <ctype.h>
int yylex();
void yyerror(char *);
%}
%union { double vd; }	
%token <vd> NUMBER
%token ID

%left '+' '-'
%left '*' '/'
%right UMINUS
%type <vd> expr
%%

lines : lines stmt
      | lines '\n'
      | /* exmpty */
      ;

stmt  : expr ';'	{ printf("%g\n", $1); }
      ;

expr  : NUMBER
      | expr '+' expr	{ $$ = $1 + $3; }
      | expr '-' expr	{ $$ = $1 - $3; }
      | expr '*' expr	{ $$ = $1 * $3; }
      | expr '/' expr	{ $$ = $1 / $3; }
      | '(' expr ')'	{ $$ = $2; }
      | '-' expr %prec UMINUS {$$ = -$2; }
      ;
%%
void yyerror(char *s){
	printf("error\n");
}
int main(){
	yyparse();
	return 0;
}

