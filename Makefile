main:y.tab.o lex.yy.o
	g++ -o hw2.out y.tab.o lex.yy.o
y.tab.h:hw2.y
		yacc -d hw2.y
y.tab.cpp:hw2.y
		yacc -o y.tab.cpp -y hw2.y
lex.yy.cpp:hw2.l y.tab.cpp y.tab.h
		lex -o lex.yy.cpp hw2.l
y.tab.o:y.tab.cpp
		g++ -c y.tab.cpp
lex.yy.o:lex.yy.cpp
		g++ -c lex.yy.cpp

clean:
	rm -rf *.o y.tab.h y.tab.cpp lex.yy.cpp *.out y.tab.c y.output lex.yy.c
