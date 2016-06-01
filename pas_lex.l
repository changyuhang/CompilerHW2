%{
#include <stdio.h>
int lineno = 1;
%}
digit		[0-9]
digits		{digit}+
number		[+-]?{digits}(\.{digits})?(E[+-]?{digits})?
letter_		[a-zA-Z_]
identifier	{letter_}({letter_}|{digit})*
literal		(\"[^\"]*\")|(\'[^\']*\')
newline		\n
whitespace	[ \t]+
%%
"var" { return VAR; }
"print" { return PRINT; }
[+-*/^()]	{return(yytext[0]);}
{number}	{ yylval.i = strtol(yytext, null, 10); return NUMBER; }
{identifier}	{yylval.s = new std::string(yytext); return ID; }
{literal}	{ yylval.s = new std::string(yytext); return STR; }
{newline}	{ lineno++; printf("\n "); }
{whitespace}	{ /* skip whitescapes */ }
.		{ printf("<ERROR>"); }
%%

int main() {
	yylex();
	return 0;
}
int yywrap(void)
{return 1;}
