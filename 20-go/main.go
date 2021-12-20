package main

import (
    "bufio"
    "os"
    "fmt"
    "math"
)

type Pair struct {
    x, y int
}

func get_neighbors(board map[Pair]int, key Pair, default_val int) ([9]int) {
    var result [9]int

    index := 0
    for y := key.y - 1; y <= key.y + 1; y++ {
        for x := key.x - 1; x <= key.x + 1; x++ {
            value, ok := board[Pair{x, y}]
            if !ok {
                value = default_val
            }
            result[index] = value
            index++
        }
    }

    return result
}

func arr2bin(bits [9]int) int {
    var result int = 0
    for _, value := range bits {
        result = result << 1 + value;
    }
    return result
}

func step(algorithm string, board map[Pair]int, step int) map[Pair]int {
    var newboard = make(map[Pair]int)

    var default_val = 0
    if step % 2 != 0 {
        default_val = 1
    }

    var min_boundX, max_boundX float64 = math.Inf(1), math.Inf(-1);
    var min_boundY, max_boundY float64 = math.Inf(1), math.Inf(-1);
    for key, _ := range board {
        min_boundX = math.Min(min_boundX, float64(key.x))
        max_boundX = math.Max(max_boundX, float64(key.x))
        min_boundY = math.Min(min_boundY, float64(key.y))
        max_boundY = math.Max(max_boundY, float64(key.y))
    }

    for y := min_boundY - 1; y <= max_boundY + 1; y++ {
        for x := min_boundX - 1; x <= max_boundX + 1; x++ {
            var key = Pair{int(x), int(y)}
            var neighbors = get_neighbors(board, key, default_val)
            var index = arr2bin(neighbors)

            if algorithm[index] == 46 {
                newboard[key] = 0
            } else {
                newboard[key] = 1
            }
        }
    }

    return newboard
}

func part1(algorithm string, board map[Pair]int) {
    var prev = board
    var current = step(algorithm, prev, 0)

    prev = current
    current = step(algorithm, prev, 1)

    var lit = 0
    for _, value := range current {
        lit += value;
    }
    fmt.Printf("[Part1] %d\n", lit);
}

func part2(algorithm string, board map[Pair]int) {
    var prev = board
    var current = step(algorithm, prev, 0)

    for i := 1; i < 50; i++ {
        prev = current
        current = step(algorithm, prev, i)
    }

    var lit = 0
    for _, value := range current {
        lit += value;
    }
    fmt.Printf("[Part2] %d\n", lit);
}

func parse_file(filename string) (string, map[Pair]int) {
    file, err := os.Open(filename)
    if err != nil {
        panic(err)
    }
    defer file.Close()

    var mode int = 0
    var algorithm string
    var board = make(map[Pair]int)
    var y int = 0

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := scanner.Text()
        if mode == 0 {
            algorithm = line
            mode = 1
        } else if (line == "") {
            continue
        } else {
            for x, char := range line {
                if char == '.' {
                    board[Pair{x, y}] =  0
                } else {
                    board[Pair{x, y}] =  1
                }
            }
            y++
        }
    }

    if err := scanner.Err(); err != nil {
        panic(err)
    }

    return algorithm, board
}

func main() {
    algorithm, board := parse_file("input.txt")
    part1(algorithm, board)
    part2(algorithm, board)
}