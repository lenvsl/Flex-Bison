%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
extern FILE *yyin;
extern FILE *yyout;
int line_count=1;
%}

%option noyywrap
digit [0-9]
letter [a-zA-Z]
num {digit}+
%%
"PROGRAM"       {yylval.string = strdup(yytext); ECHO;return PROGRAM;}
"STARTMAIN"     {yylval.string = strdup(yytext); ECHO;return STARTMAIN;}
"VARS"          {yylval.string = strdup(yytext); ECHO;return VARS;}
"CHAR"          {yylval.string = strdup(yytext); ECHO;return CHAR;}
"INTEGER"       {yylval.string = strdup(yytext); ECHO;return INTEGER;}
"STRUCT"        {yylval.string = strdup(yytext); ECHO;return STRUCT;}
"TYPEDEF"       {yylval.string = strdup(yytext); ECHO;return TYPEDEF;}
"ENDSTRUCT"     {yylval.string = strdup(yytext); ECHO;return ENDSTRUCT;}
"FUNCTION"      {yylval.string = strdup(yytext); ECHO;return FUNCTION;}
"RETURN"        {yylval.string = strdup(yytext); ECHO;return RETURN;}
"END_FUNCTION"	{yylval.string = strdup(yytext); ECHO;return END_FUNCTION;}
"ENDMAIN"       {yylval.string = strdup(yytext); ECHO;return ENDMAIN;}
"WHILE"         {yylval.string = strdup(yytext); ECHO;return WHILE;}
"ENDWHILE"      {yylval.string = strdup(yytext); ECHO;return ENDWHILE;}
"FOR"           {yylval.string = strdup(yytext); ECHO;return FOR;}
"TO"            {yylval.string = strdup(yytext); ECHO;return TO;}
"STEP"          {yylval.string = strdup(yytext); ECHO;return STEP;}
"ENDFOR"        {yylval.string = strdup(yytext); ECHO;return ENDFOR;}
"IF"            {yylval.string = strdup(yytext); ECHO;return IF;}
"THEN"          {yylval.string = strdup(yytext); ECHO;return THEN;}
"ELSEIF"        {yylval.string = strdup(yytext); ECHO;return ELSEIF;}
"ELSE"          {yylval.string = strdup(yytext); ECHO;return ELSE;}
"ENDIF"         {yylval.string = strdup(yytext); ECHO;return ENDIF;}
"SWITCH"        {yylval.string = strdup(yytext); ECHO;return SWITCH;}
"CASE"          {yylval.string = strdup(yytext); ECHO;return CASE;}
"DEFAULT"       {yylval.string = strdup(yytext); ECHO;return DEFAULT;}
"ENDSWITCH"     {yylval.string = strdup(yytext); ECHO;return ENDSWITCH;}
"PRINT"         {yylval.string = strdup(yytext); ECHO;return PRINT;}
"BREAK"         {yylval.string = strdup(yytext); ECHO;return BREAK;}
"AND"           {yylval.string = strdup(yytext); ECHO;return AND;}
"OR"            {yylval.string = strdup(yytext); ECHO;return OR;}
"("             {yylval.string = strdup(yytext); ECHO;return LEFTBRA; }
"["             {yylval.string = strdup(yytext); ECHO;return LEFTSTRBRA; }
">"             {yylval.string = strdup(yytext); ECHO;return MEGALYTERO ; }
"<"             {yylval.string = strdup(yytext); ECHO;return MIKROTERO ; }
"!"             {yylval.string = strdup(yytext); ECHO;return THAYMASTIKO ; }
"="             {yylval.string = strdup(yytext); ECHO;return ISON ;  }
","             {yylval.string = strdup(yytext); ECHO;return COMMA ; }
"]"             {yylval.string = strdup(yytext); ECHO;return RIGHTSTRLBRA ;}
")"             {yylval.string = strdup(yytext); ECHO;return RIGHTBRA ;  }
":"             {yylval.string = strdup(yytext); ECHO;return ANOKATOTEL ; }
";"             {yylval.string = strdup(yytext); ECHO;return EROTIMATIKO ;  }
"+"             {yylval.string = strdup(yytext); ECHO;return SYN ; }
"-"             {yylval.string = strdup(yytext); ECHO;return PLIN; }
"*"             {yylval.string = strdup(yytext); ECHO;return MUL ; }
"/"	            {yylval.string = strdup(yytext); ECHO;return DIV;  }
"^"	            {yylval.string = strdup(yytext); ECHO;return POW; }
"%"             {yylval.string = strdup(yytext); ECHO;return TISEKATO ; }
"/*"            {yylval.string = strdup(yytext); ECHO;return COMSTART; }
"*/"            {yylval.string = strdup(yytext); ECHO;return COMEND; }
[\n]            {line_count++ ;yylval.string = strdup(yytext); ECHO; return CHANGE_LINE ; }
[ \t]*          {yylval.string = strdup(yytext); ECHO;}
{num}           {yylval.string = strdup(yytext); ECHO; return INT; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.string = strdup(yytext); ECHO; return NAME; }
%%
