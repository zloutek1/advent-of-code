CC=gcc
CFLAGS= -std=c99 -pedantic -Wall -Wextra -g

all: compile run clean
debug: compile valgrind clean

compile main.c:
	$(CC) $(CFLAGS) main.c -o main

valgrind main:
	valgrind --leak-check=full --track-origins=yes --show-reachable=yes ./main

run:
	./main

clean:
	rm -f main vgcore.*

