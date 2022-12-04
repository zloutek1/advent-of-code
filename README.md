# Advent of Code 2022

For this year I have decided to use [APL](https://en.wikipedia.org/wiki/APL_(programming_language)


## How to run 

### via Docker
```console
docker build -t aoc .
docker run -t aoc
```

### manually
To run all days run `run.sh`
To run single day run `run.sh dayX`


## Add new day
Upload `example.txt` with the example and create `example.ans.txt` with expected results.

Then upload `input.txt` with your input. `run.sh dayX` will print calculated values. After successful creation you can create `input.ans.txt` to add your results to tests.