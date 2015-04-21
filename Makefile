.PHONY: all
all: build

.PHONY: build
build: 0calc

.PHONY: clean
clean:
	rm -f 0calc lex.yy.c y.tab.c y.tab.h *.o

0calc: lex.yy.o y.tab.o
	cc -o $@ $^

lex.yy.o: lex.yy.c y.tab.h

lex.yy.c: 0calc.l
	flex $^

y.tab.c y.tab.h: 0calc.y
	bison -dy $^
