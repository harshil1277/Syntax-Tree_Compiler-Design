%{
#include "y.tab.h"
int yylex();
extern void printRow(char* lexeme,char* dataType,char* symbolType);
void comment(void);
%}

%%

#include.*                                      {printRow(yytext, "N/A", "HEADER"); return HEADER;}  /* Match and return HEADER token for #include lines */
"/*"                                            { comment(); }     /* Call the comment function for /* comments */
"//"[^\n]*                                      { /* consume //-comment */ } /* Ignore // comments */
"break"                                         { return BREAK; }   /* Match and return BREAK token for "break" */
"continue"                                      { return CONTINUE; } /* Match and return CONTINUE token for "continue" */
"int"                                           {printRow(yytext, "int", "KEYWORD"); return INT;}  /* Match and return INT token for "int" */
"main"                                          {printRow(yytext, "N/A", "KEYWORD"); return MAIN;}  /* Match and return MAIN token for "main" */
"for"                                           {printRow(yytext, "N/A", "KEYWORD"); return FOR;}   /* Match and return FOR token for "for" */
"while"                                         {printRow(yytext, "N/A", "KEYWORD"); return WHILE;} /* Match and return WHILE token for "while" */
"if"                                            {printRow(yytext, "N/A", "KEYWORD"); return IF;}    /* Match and return IF token for "if" */
"else"                                          {printRow(yytext, "N/A", "KEYWORD"); return ELSE;}  /* Match and return ELSE token for "else" */
"return"                                        {printRow(yytext, "N/A", "KEYWORD"); return RETURN;} /* Match and return RETURN token for "return" */
"printf"                                        {printRow(yytext, "N/A", "KEYWORD"); return PRINTF;} /* Match and return PRINTF token for "printf" */
"scanf"                                         {printRow(yytext, "N/A", "KEYWORD"); return SCANF;}  /* Match and return SCANF token for "scanf" */
"++"                                            { return PLUS_PLUS; } /* Match and return PLUS_PLUS token for "++" */
"+="                                            { return PLUS_EQ; }   /* Match and return PLUS_EQ token for "+=" */
"--"                                            { return MINUS_MINUS; } /* Match and return MINUS_MINUS token for "--" */
"-="                                            { return MINUS_EQ; }  /* Match and return MINUS_EQ token for "-=" */
\"(\\.|[^\"])*\"                                {printRow(yytext, "char*", "CONSTANT"); return QUOTED_STRING;}  /* Match and return QUOTED_STRING token for strings */
"=="                                            { return EQ_EQ; }     /* Match and return EQ_EQ token for "==" */
"!="                                            { return NOT_EQ; }     /* Match and return NOT_EQ token for "!=" */
">="                                            { return G_EQ; }      /* Match and return G_EQ token for ">=" */
"<="                                            { return L_EQ; }      /* Match and return L_EQ token for "<=" */
[-+*/;,.()&{}=<>!]                              { return yytext[0]; }    /* Match and return single-character tokens */
[0-9]+                                          {printRow(yytext, "int", "CONSTANT"); return CONST_INT;}  /* Match and return CONST_INT token for integers */
[_a-zA-Z][_a-zA-Z0-9]*                          {printRow(yytext, "int", "IDENTIFIER"); return IDENTIFIER;}  /* Match and return IDENTIFIER token for identifiers */
[ \t\n]                                         {;}                   /* Ignore spaces, tabs, and newlines */
.                                               {printf("unexpected character %s\n", yytext);} /* Handle unexpected characters */
%%

int yywrap (void)
{
    return 1;
}

void comment(void)
{
    char c, prev = 0;
  
    while ((c = input()) != 0)  /* Loop until the end of the comment block (EOF maps to 0) */
    {
        if (c == '/' && prev == '*') /* Check for the end of a /* comment */
            return;
        prev = c;
    }
    printf("unterminated comment"); /* Handle unterminated comments */
}
