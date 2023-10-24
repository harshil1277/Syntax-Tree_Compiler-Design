%{
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <string.h>


void yyerror (char *s);
int yylex();
int flag=0;
int sz=0;
char* symbols[100000];
void printRow(char* lexeme,char* dataType,char* symbolType);
int foundSymbolTable(char* lexeme);
void insertSymbolTable(char * lexeme);
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
PROGRAM:    HEADERS  INT MAIN '(' ')' '{' STATEMENTS '}'    {printf("\nParsing Successful\n");}
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
int foundSymbolTable(char* lexeme){
    for(int i=0;i<sz;i++)
        if(!strcmp(symbols[i],lexeme))
            return 1;
    return 0;
}
void insertSymbolTable(char * lexeme){
    symbols[sz] = (char*)malloc(sizeof(strlen(lexeme)+1));
    strcpy(symbols[sz],lexeme);
    sz++;
}

void printRow(char* lexeme,char* dataType,char* symbolType){
    if(!flag){
    char lex[] = "LEXEME",datty[]="DATATYPE",smbty[] = "SYMBOL TYPE";
        printf("%20s%20s%20s\n",lex,datty,smbty);
        printf("%20s%20s%20s\n","----------","----------","----------");
        flag=1;
    }

    if(!foundSymbolTable(lexeme)){
        printf("%20s%20s%20s\n",lexeme,dataType,symbolType);
        insertSymbolTable(lexeme);
    }
}

