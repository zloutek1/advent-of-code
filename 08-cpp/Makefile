CXX      = g++
CXXFLAGS = -std=c++17 -g

all: compile run clean
debug: compile valgrind clean

compile:
	$(CXX) $(CXXFLAGS) -o main main.cpp

run:
	./main

valgrind:
	valgrind ./main

clean:
	rm -f main vgcore.*
