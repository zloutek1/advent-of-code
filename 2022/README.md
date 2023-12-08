# Advent of Code 2022

This repository contains my solutions to the 2021 Advent of Code puzzles. 

For this year I have decided to use [APL](https://en.wikipedia.org/wiki/APL_(programming_language)). APL's syntax uses a set of special characters as operators and function names, which can make it somewhat difficult for those unfamiliar with the language to read. However, its concise and expressive nature makes it well-suited for certain types of problems, such as data manipulation and analysis.

Each solution is contained in a separate directory, named for the day it corresponds to (e.g. **01**, **02**, etc.). Within each directory, you will find the following files:
- `example.txt`: The input data for the puzzle, provided by Advent of Code.
- `example.ans.txt`: The snapshot data for the expected stdout. This is checked by tests
- `main.apl`: My solution to the puzzle, written in APL.

## How to run 

### via Docker
```console
docker build -t aoc .
docker run -t aoc
```

### manually
To run all days run `run.sh`
To run single day run `run.sh dayX`
