%{
#include <stdio.h>
#include <math.h>
#include <string.h>
extern FILE *yyin;
extern FILE *yyout;
extern int yylex();
extern int yyparse();
extern char* yytext();
extern int line_count;
void yyerror(const char *s);
int error=0;
int count=0;
int found=0;
%}


%token<string> PROGRAM NAME CHANGE_LINE STARTMAIN ENDMAIN FUNCTION  LEFTBRA  RIGHTBRA
%token<string> RETURN END_FUNCTION VARS CHAR INTEGER EROTIMATIKO INT BREAK
%token<string> PRINT LEFTSTRBRA COMMA  RIGHTSTRLBRA TISEKATO  WHILE ENDWHILE
%token<string> FOR ANOKATOTEL ISON TO STEP  ENDFOR MEGALYTERO MIKROTERO THAYMASTIKO AND OR
%token<string> IF THEN ELSEIF ELSE ENDIF SWITCH CASE DEFAULT ENDSWITCH SYN PLIN MUL DIV POW
%token<string> STRUCT TYPEDEF ENDSTRUCT TEXT COMSTART COMEND SPACE

%left SYN PLIN
%left MUL DIV
%right POW

%start start

%union{
char* string;
}

%type<string> start program body function functions main  var type_specifier var2
%type<string> commands command  comment loop while for list condition symbol logic
%type<string> print conditions if switch assignment func break symbol2 lines multiple
%type<string> structs struct big_comment words

%%

start: program         {fprintf(yyout, $1);};
program: PROGRAM NAME lines body ;

lines: CHANGE_LINE
| CHANGE_LINE lines
;

body:main
|structs main
|structs functions main;

structs: %empty {}
|struct structs
;

struct: STRUCT NAME lines var ENDSTRUCT lines{
								if (strcmp($2,"kiriaki") == 0 && count < 1) {count++;}
 								else if (strcmp($2,"kiriaki") != 0){ yyerror("Wrong type for the struct\n") ;}
								else {yyerror("The struct already exists\n");};}

|TYPEDEF STRUCT NAME lines var big_comment NAME ENDSTRUCT lines{
								if (strcmp($3,"kiriaki") == 0 && strcmp($7,"kiriaki") == 0 && count < 1) {count++;}
 								else if (strcmp($3,"kiriaki") != 0){ yyerror("Wrong type for the struct\n") ;}
								else if (strcmp($3,"kiriaki") == 0 && strcmp($7,"kiriaki") != 0){ yyerror("The name at the end is not the same with the beginning \n") ;}
 								else {yyerror("The struct already exists\n");};}
;

functions: function
	| function functions
;

function: FUNCTION NAME LEFTBRA list RIGHTBRA  lines var commands


/*
{ char* x; int i; int found;
	for(i = 0; i < 4; i++){if(strcmp($2, x) == 0 ){ found=1;}else{};}
	if (found=0) {$2 = x;}
	else if (found>0) {yyerror("The function already exists");}
	 ;}
*/



RETURN NAME lines END_FUNCTION lines
;


list: NAME
  | NAME COMMA list
	| NAME LEFTSTRBRA INT RIGHTSTRLBRA
	| NAME LEFTSTRBRA INT RIGHTSTRLBRA COMMA list
;
var: %empty {}
| var2 var;

var2: VARS lines multiple
;
multiple: %empty {}
|type_specifier list EROTIMATIKO lines multiple;

type_specifier: CHAR
	| INTEGER
	| NAME {if (strcmp($1,"kiriaki")!=0){yyerror("This type does not exist");}
					else {};}
;
commands: command
	| command commands
;
command:comment
|loop
|conditions
|print
|assignment
|big_comment

;

loop: while
	| for
;

while: WHILE LEFTBRA condition RIGHTBRA lines break commands
break ENDWHILE lines
;

for: FOR NAME ANOKATOTEL ISON INT TO INT STEP INT lines
 break commands break ENDFOR lines
;

conditions: if
	| switch
;

if: IF LEFTBRA condition RIGHTBRA THEN lines commands elseif2 else ENDIF lines
;

elseif2: %empty {}
	| ELSEIF lines commands elseif2
;

else: %empty
| ELSE lines commands
;

switch: SWITCH LEFTBRA condition RIGHTBRA lines case2 default ENDSWITCH lines
;

case2: %empty {}
	| case case2
;

case: CASE LEFTBRA condition RIGHTBRA ANOKATOTEL lines break commands break
;

default: %empty {}
	|  DEFAULT ANOKATOTEL lines break commands break
;

print: PRINT LEFTBRA words RIGHTBRA EROTIMATIKO lines
|PRINT LEFTBRA words LEFTSTRBRA COMMA NAME RIGHTSTRLBRA RIGHTBRA EROTIMATIKO lines
;

condition: NAME symbol NAME
	| condition logic condition

;

symbol: MEGALYTERO
|MIKROTERO
|ISON ISON
|THAYMASTIKO
;

logic: AND
| OR
;

assignment: NAME ISON expression EROTIMATIKO lines
;

expression: INT
	| func
	| NAME
	| expression symbol2 expression
	| LEFTBRA expression RIGHTBRA
;

symbol2: SYN
|PLIN
|MUL
|DIV
|POW
;

func: NAME LEFTBRA list RIGHTBRA
;

break: %empty {}
	| BREAK EROTIMATIKO lines
;

comment: TISEKATO words lines
;

big_comment: COMSTART words COMEND lines
|COMSTART CHANGE_LINE test COMEND lines
;

test: %empty {}
|words CHANGE_LINE test
| lines test
|command test
;
main: STARTMAIN lines var commands ENDMAIN lines
;
words: NAME
| NAME words
;


%%
void yyerror(const char *s) {
    printf("error %s\n",s);

    fprintf(yyout,"\n%s at line %d",s,line_count);
		error++ ;
}



int main ( int argc, char **argv  )
  {
  ++argv; --argc;
  if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
  else
        yyin = stdin;
  yyout = fopen ( "output", "w" );
  yyparse ();
	printf("errors: %d",error);
  return 0;
}
