#include <stdio.h>
#include "y.tab.h"

extern int yylex();
extern int lineno;
extern int yylineno;
extern char* yytext;


int main(void)
{

    int ntoken, vtoken;

    ntoken = yylex();
    while (ntoken) {
        printf("%d %s\n", lineno, yytext);
        ntoken = yylex();
    }
    return 0;
}