%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char *s);   // Error function for custom error handling
int yylex();
%}

%token HEADER
%token IDENTIFIER QUOTED_STRING CONST_INT
%token MAIN FOR WHILE IF ELSE RETURN PRINTF SCANF BREAK CONTINUE
%token PLUS_PLUS PLUS_EQ MINUS_MINUS MINUS_EQ G_EQ L_EQ EQ_EQ NOT_EQ
%token INT
%nonassoc IFX
%nonassoc ELSE
%left '*' '/'   // Define precedence for operators
%left '+' '-'   // Define precedence for operators

%start PROGRAM

%%

PROGRAM: HEADERS INT MAIN '(' ')' '{' STATEMENTS '}' { printf("Parsing successful\n"); }
            ;   // Define the main program structure

HEADERS:
    | HEADERS HEADER // Handling multiple headers
    ;

STATEMENTS:
    | STATEMENTS STATEMENT // Handling multiple statements
    ;

STATEMENT: ';'
    | DECLARATION_STATEMENT ';' // Declaration statement
    | INCREMENT ';' // Increment operation
    | DECREMENT ';' // Decrement operation
    | BREAK ';' // Break statement
    | CONTINUE ';' // Continue statement
    | LOOP_BLOCK // Loops (for, while)
    | IF_ELSE_BLOCK // If-else blocks
    | ASSIGNMENT_STATEMENT ';' // Assignment statement
    | RETURN_STATEMENT ';' // Return statement
    | PRINTF_STATEMENT ';' // Printf statement
    | SCANF_STATEMENT ';' // Scanf statement
    ;

DECLARATION_STATEMENT: INT IDENTIFIER // Variable declaration
    | INT IDENTIFIER '=' EXPRESSION // Variable declaration with assignment
    ;

LOOP_BLOCK: FOR_LOOP // For loop
    | WHILE_LOOP // While loop
    ;

FOR_LOOP: FOR '(' DECLARATION_STATEMENT ';' CONDITION ';' UPDATION ')' '{' STATEMENTS '}' // For loop structure
    ;

WHILE_LOOP: WHILE '(' CONDITION ')' '{' STATEMENTS '}' // While loop structure
    ;

UPDATION: INCREMENT // Increment operation
    | DECREMENT // Decrement operation
    | ASSIGNMENT_STATEMENT // Assignment operation
    ;

CONDITION: '(' RVALUE ')' // Simple condition
    | RVALUE '<' RVALUE // Less than condition
    | RVALUE '>' RVALUE // Greater than condition
    | RVALUE G_EQ RVALUE // Greater than or equal condition
    | RVALUE L_EQ RVALUE // Less than or equal condition
    | RVALUE EQ_EQ RVALUE // Equal condition
    | RVALUE NOT_EQ RVALUE // Not equal condition
    | '!' RVALUE // Not condition
    | IDENTIFIER // Identifier
    | CONST_INT // Integer constant
    ;

RVALUE: IDENTIFIER // Identifier as RValue
    | CONST_INT // Integer constant as RValue
    ;

INCREMENT: IDENTIFIER PLUS_PLUS // Increment operation
    | IDENTIFIER PLUS_EQ EXPRESSION // Plus-equal operation
    ;

DECREMENT: IDENTIFIER MINUS_MINUS // Decrement operation
    | IDENTIFIER MINUS_EQ EXPRESSION // Minus-equal operation
    ;

ASSIGNMENT_STATEMENT: IDENTIFIER '=' EXPRESSION // Assignment operation
    ;

IF_ELSE_BLOCK: IF_BLOCK %prec IFX // If block
    | IF_BLOCK ELSE_BLOCK // If-else block
    ;

IF_BLOCK: IF '(' CONDITION ')' '{' STATEMENTS '}' // If block structure
    ;

ELSE_BLOCK: ELSE '{' STATEMENTS '}' // Else block structure
    ;

RETURN_STATEMENT: RETURN EXPRESSION // Return statement
    ;

PRINTF_STATEMENT: PRINTF '(' PRINTF_FORMAT ')' // Printf statement
    ;

PRINTF_FORMAT: QUOTED_STRING // Printf format string
    | QUOTED_STRING ',' ARGUMENTS // Printf format string with arguments
    ;

SCANF_STATEMENT: SCANF '(' SCANF_FORMAT ')' // Scanf statement
    ;

SCANF_FORMAT: QUOTED_STRING ',' ARGUMENTS // Scanf format string with arguments
    ;

ARGUMENTS: ARGUMENTS ',' IDENTIFIER // Arguments for Printf/Scanf
    | ARGUMENTS ',' '&' IDENTIFIER // Arguments with references
    | IDENTIFIER // Single argument
    | '&' IDENTIFIER // Single argument with reference
    ;

EXPRESSION: '(' EXPRESSION ')' // Expression within parentheses
    | EXPRESSION '+' EXPRESSION // Addition operation
    | EXPRESSION '-' EXPRESSION // Subtraction operation
    | EXPRESSION '*' EXPRESSION // Multiplication operation
    | EXPRESSION '/' EXPRESSION // Division operation
    | '-' EXPRESSION %prec '*' // Unary minus operation
    | IDENTIFIER // Identifier as expression
    | CONST_INT // Integer constant as expression
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s); // Custom error handling function
}

int main(void) {
    return yyparse(); // Main entry point for parsing
}
