%{
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>

void yyerror (char* s);
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
PROGRAM:    HEADERS  INT MAIN '(' ')' '{' STATEMENTS '}'    {printf("Parsing Successful\n");}
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
            | BREAK ';'  
            | CONTINUE ';'
            | LOOP_BLOCK
            | IF_ELSE_BLOCK
            | ASSIGNMENT_STATEMENT ';'
            | RETURN_STATEMENT ';'
            | PRINTF_STATEMENT ';'
            | SCANF_STATEMENT ';'
            ;


DECLARATION_STATEMENT:  INT IDENTIFIER
                        | INT IDENTIFIER '=' EXPRESSION 
                        ;


LOOP_BLOCK: FOR_LOOP 
            | WHILE_LOOP
            ;
FOR_LOOP :  FOR '(' DECLARATION_STATEMENT ';' CONDITION ';' UPDATION ')' '{' STATEMENTS '}'
            ;
WHILE_LOOP: WHILE '(' CONDITION ')' '{' STATEMENTS '}'
            ;

UPDATION :  INCREMENT 
            | DECREMENT 
            | ASSIGNMENT_STATEMENT
            ;

CONDITION:  '(' RVALUE ')'
            | RVALUE '<' RVALUE
            | RVALUE '>' RVALUE
            | RVALUE G_EQ RVALUE
            | RVALUE L_EQ RVALUE
            | RVALUE EQ_EQ RVALUE
            | RVALUE NOT_EQ RVALUE
            | '!' RVALUE
            | IDENTIFIER
            | CONST_INT
            ;
RVALUE: IDENTIFIER
        | CONST_INT
        ;


INCREMENT:  IDENTIFIER PLUS_PLUS 
            | IDENTIFIER PLUS_EQ EXPRESSION
            ;
DECREMENT:  IDENTIFIER MINUS_MINUS
            | IDENTIFIER MINUS_EQ EXPRESSION
            ;


ASSIGNMENT_STATEMENT:   IDENTIFIER '=' EXPRESSION
                        ;

IF_ELSE_BLOCK:  IF_BLOCK %prec IFX
                | IF_BLOCK ELSE_BLOCK
                ;

IF_BLOCK:   IF '(' CONDITION ')' '{' STATEMENTS '}' 
            ;

ELSE_BLOCK:     ELSE '{' STATEMENTS '}'
                ;
RETURN_STATEMENT:   RETURN EXPRESSION
                    ;

PRINTF_STATEMENT:   PRINTF '(' PRINTF_FORMAT ')'
                    ;

PRINTF_FORMAT:  QUOTED_STRING 
                | QUOTED_STRING ',' ARGUMENTS
                ;

SCANF_STATEMENT:    SCANF '(' SCANF_FORMAT ')'
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

void yyerror (char *s) {printf ("Parsing Failed: %s\n",s);}
