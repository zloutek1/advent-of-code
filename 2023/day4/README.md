
# Day 4

## Part 1

```lua
=LET(winning, TEXTSPLIT(TRIM(B3), " "),
         guessed, TEXTSPLIT(TRIM(C3), " "),
         matches, SUM(MAP(winning, LAMBDA(n, OR(n = guessed) * 1))),
         IF(matches = 0, 0, POWER(2, matches - 1)))
```