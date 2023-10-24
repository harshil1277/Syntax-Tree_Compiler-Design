# Syntax-Tree_Compiler-Design

Team Members:

- Harshil Kaneria - B21CS033
- Amisha Kumari - B21CS007

## Frontend Phase of a C Compiler

### Using the Compiler

```
// Open Linux Terminal
// run command
sudo apt-get install flex
sudo apt-get install bison

// Restart the terminal

// Go to the directory having PA2.sh shell file
// Add you C program in input.c file in the directory
// Right Click and Click on "Open in Terminal"
// Run the following command

bash PA2.sh 
```

### What is LEX?

LEX is a tool used to generate a lexical analyzer. The input is a set of regular expressions in addition to actions. The output is a table driven scanner called lex.yy.c.

### What is YACC?

YACC (Yet Another Compiler Compiler) is a tool used to generate a parser. It parses the input file and does semantic analysis on the stream of tokens produced by the LEX file. YACC translates a given Context Free Grammar (CFG) specifications into a C implementation y.tab.c. This C program when compiled, yields an executable parser.

### Features of the repository

- Symbol Table
- Parse Tree and AST

### What the Syntax Tree accepts?

- Simple C programs - declaration and assignment, printf, scanf and arithmetic operations ( + , - , * , / )
- Simple for loops and if-else statements (no else if)
- Nested for loops and if-else statements

#### Assumptions

- Program : contains some optional headers followed by a single main function which contains some statements. Both single line and multi-line comments are allowed.
- Statements: consists of declarative, iterative, conditional, assignment and update statements along with two functions “printf” and “scanf” and a return and an empty (;) statement.
- Data Types :- We are only allowing integer variables
- Iterative Statements : consists of for loop and while loop
- for loop :- We will be following default for loop syntax i.e, single declaration, single condition and single updation statement
- Cannot skip { } even if only one statement inside the for block
- while loop :- Cannot skip { } even if only one statement inside the while block
- Updation statements : considers only incrementing and decrementing variables (++, +=, --, -=)
- if else statements
-- consists of if : requires { } even if only one statement
-- else : requires { } even if only one statement
-- else if statements are not allowed
- Expressions : allowing only binary arithmetic operators [-, +, *, /], negation, multiple variables and constants.
- Conditions : considering only single relational operators [<, <=, >, >=, ==, !=], negation(!), two operands (identifiers or constants).
- We are using bottom up parser, Post Order Traversal of parse tree is printed.


### Phases of the Compiler

The final parser takes a C program with nested for loops or if-else blocks and performs lexical and syntax analysis. Let’s look at the implementation of each phase in detail:

#### Lexer and Context-Free Grammar

The first step was to code the lexer file to take the stream of characters from the input programs and identify the tokens defined with the help of regular expressions. Next, the yacc file was created, which contained the context-free grammar that accepts a complete C program constituting headers, main function, variable declarations, and initializations, nested for loops, if-else constructs, and expressions of the form of binary arithmetic and unary operations. At this stage, the parser will accept a program with the correct structure and throw a syntax error if the input program is not derived from the CFG.

#### Syntax Analysis

We are directly printing post order traversal of Syntax Tree because we are doing bottom up parsing. We have included print statements for every grammer production so that post order can be printed.

### Example of the Compiler in Action

```
#include<stdio.h>
#include<string.h>

int main() {
    int a;
    int x=1;
    int y=2;
    int z=3;
    x=3;
    y=10;
    z=5;
    if(x>5) {
        for(int k=0; k<10; k++) {
            y = x+3;
            printf("Hello!");
        }
    } else {
        int idx = 1;
    }
    for(int i=0; i<10; i++) {
        printf("Hello World!");
        scanf("%d", &x);
        if (x>5) {
            printf("Hi");
        }
        for(int j=0; j<z; j++) {
            a=1;
        }
    } 
    return 1;
}
```

#### Symbol Table

![Symbol Table](// image path of output of symbol table)

#### Printing Parse Tree Inorder 

![Symbol Table](//image path of inorder output image)

#### Visualising the Parse Tree 

![Symbol Table](//image path of visualization)


