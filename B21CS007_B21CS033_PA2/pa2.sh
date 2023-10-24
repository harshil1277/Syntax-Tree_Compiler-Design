echo "Task 1 - Generating tokens"
yacc -d parser1.y # to generate y.tab.h file
lex analyzer1.l
gcc scanner.c lex.yy.c -o scanner 
./scanner < input.c

echo "Task 2 - Checking grammar"
yacc -d parser2.y
lex analyzer2.l
gcc -g lex.yy.c y.tab.c -o compiler
./compiler <input.c

echo "Task 3 - Generating symbol table"
yacc -d parser3.y
lex analyzer3.l
gcc -g lex.yy.c y.tab.c -o compiler
./compiler <input.c

echo "Task 4 - Generating syntax tree"
yacc -d parser4.y
lex analyzer4.l
gcc -g lex.yy.c y.tab.c -o compiler
./compiler <input.c



