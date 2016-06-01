%option noyywrap
%{
#include <stdio.h>
#include <string>
#include <iostream>
#include <stdlib.h>
#include "y.tab.h"
int lineno = 1;
char *p=NULL;
%}
digit		 [0-9]
digits		{digit}+
number		[-]?{digits}(\.{digits})?(E[+-]?{digits})?
letter_		[a-zA-Z_]
identifier	{letter_}({letter_}|{digit})*
literal		(\"[^\"]*\")|(\'[^\']*\')
float_num [+-]?[0-9]+\.[0-9]+
newline		\n
whitespace	[ \t]+
%%
"var" { return VAR; }
"print" { return PRINT; }
[-+*/^=,;] { return *yytext;}
{float_num}   {yylval.f=strtof(yytext, &p); return FLOAT_NUMBER;}
{number}	{ yylval.f = strtof(yytext, &p); return NUMBER; }
{identifier}	{yylval.s = new std::string(yytext); return ID; }
{literal}	{
                std::string temp(yytext);
                temp.replace(0,1,"");
                temp.replace(temp.length()-1,temp.length()-1,"");
                //std::cout<<temp<<std::endl;
                yylval.s = new std::string(temp);
                return STR;
            }
{whitespace} {}
{newline} {}
.|\n	{ /* skip whitescapes */ }
%%
