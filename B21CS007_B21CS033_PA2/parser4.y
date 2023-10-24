%{
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>


void yyerror (char *s);
int yylex();
%}

%token HEADER
%token IDENTIFIER QUOTED_STRING CONST_INT 
%token PLUS_PLUS PLUS_EQ MINUS_MINUS MINUS_EQ G_EQ L_EQ EQ_EQ NOT_EQ
%token INT 
%token MAIN FOR WHILE IF ELSE RETURN PRINTF SCANF BREAK CONTINUE
%nonassoc IFX
%nonassoc ELSE
%left  '+'  '-'
%left  '*'  '/'

%start PROGRAM




%%
PROGRAM:    HEADERS {printf("HEADERS\n");}  INT MAIN '(' ')' '{' STATEMENTS {printf("BODY\n");} '}'    {printf("PROGRAM\n");}
            ;

HEADERS:    
            | HEADERS HEADER
            ;

STATEMENTS: 
            | STATEMENTS STATEMENT 
            ; 
STATEMENT:  ';'
            | DECLARATION_STATEMENT ';'
            | INCREMENT ';' 
            | DECREMENT ';' 
            | LOOP_BLOCK    
            | BREAK ';'  {printf("BREAK STATEMENT\n");}
            | CONTINUE ';'{printf("CONTINUE STATEMENT\n");}
            | IF_ELSE_BLOCK
            | ASSIGNMENT_STATEMENT ';' 
            | RETURN_STATEMENT ';' 
            | PRINTF_STATEMENT ';' 
            | SCANF_STATEMENT ';' 
            ;


DECLARATION_STATEMENT:  INT IDENTIFIER {printf("DECLARATION STATEMENT\n");}
                        | INT IDENTIFIER '=' EXPRESSION  {printf("DECLARATION STATEMENT\n");}
                        ;


LOOP_BLOCK: FOR_LOOP 
            | WHILE_LOOP
            ;
FOR_LOOP :  FOR '(' DECLARATION_STATEMENT ';' CONDITION  ';' UPDATION ')' '{' STATEMENTS '}' {printf("LOOP BLOCK\n");}
            ;
WHILE_LOOP: WHILE '(' CONDITION ')' '{' STATEMENTS '}'
            ;

UPDATION :  INCREMENT 
            | DECREMENT 
            | ASSIGNMENT_STATEMENT
            ;

CONDITION:  '(' RVALUE ')' {printf("CONDITION\n");}
            | RVALUE '<' RVALUE {printf("CONDITION\n");}
            | RVALUE '>' RVALUE {printf("CONDITION\n");}
            | RVALUE G_EQ RVALUE {printf("CONDITION\n");}
            | RVALUE L_EQ RVALUE {printf("CONDITION\n");}
            | RVALUE EQ_EQ RVALUE {printf("CONDITION\n");}
            | RVALUE NOT_EQ RVALUE {printf("CONDITION\n");}
            | '!' RVALUE {printf("CONDITION\n");}
            | IDENTIFIER {printf("CONDITION\n");}
            | CONST_INT {printf("CONDITION\n");}
            ;
RVALUE: IDENTIFIER
        | CONST_INT
        ;


INCREMENT:  IDENTIFIER PLUS_PLUS  {printf("INCREMENT STATEMENT\n");}
            | IDENTIFIER PLUS_EQ EXPRESSION {printf("INCREMENT STATEMENT\n");}
            ;
DECREMENT:  IDENTIFIER MINUS_MINUS {printf("DECREMENT STATAMENT\n");}
            | IDENTIFIER MINUS_EQ EXPRESSION {printf("DECREMENT STATAMENT\n");}
            ;


ASSIGNMENT_STATEMENT:   IDENTIFIER '=' EXPRESSION {printf("ASSIGNMENT\n");}
                        ;

IF_ELSE_BLOCK:  IF_BLOCK %prec IFX  {printf("IF BLOCK\n");}
                | IF_BLOCK ELSE_BLOCK  {printf("IF ELSE BLOCK\n");}
                ;

IF_BLOCK:   IF '(' CONDITION ')' '{' STATEMENTS '}' 
            ;

ELSE_BLOCK:     ELSE '{' STATEMENTS '}'
                ;
RETURN_STATEMENT:   RETURN EXPRESSION {printf("RETURN STATEMENT\n");}
                    ;

PRINTF_STATEMENT:   PRINTF '(' PRINTF_FORMAT ')'  {printf("PRINTF CALL\n");}
                    ;

PRINTF_FORMAT:  QUOTED_STRING 
                | QUOTED_STRING ',' ARGUMENTS
                ;

SCANF_STATEMENT:    SCANF '(' SCANF_FORMAT ')' {printf("SCANF CALL\n");}
                    ;

SCANF_FORMAT:   QUOTED_STRING ',' ARGUMENTS
                ;
ARGUMENTS:  ARGUMENTS ',' IDENTIFIER
            | ARGUMENTS ',' '&'IDENTIFIER
            | IDENTIFIER
            | '&'IDENTIFIER
            ;

EXPRESSION: '(' EXPRESSION ')'
            | EXPRESSION '+' EXPRESSION
            | EXPRESSION '-' EXPRESSION
            | EXPRESSION '*' EXPRESSION
            | EXPRESSION  '/' EXPRESSION
            | '-' EXPRESSION %prec  '*'
            | IDENTIFIER
            | CONST_INT
            ;

%%    





int main (void) {

    return yyparse ();
}

void yyerror (char *s) {printf ("Parsing Failed: %s",s);}

