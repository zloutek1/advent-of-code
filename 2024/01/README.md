# Day 01

## Input transformation

```lua
=TEXTSPLIT(source, "   ", CHAR(10))
```

## Part1

```lua
=LET(
     left_sorted, SORT(CHOOSECOLS(input, 1)),
     right_sorted, SORT(CHOOSECOLS(input, 2)),
     SUM(ABS(left_sorted - right_sorted))
)				
```

## Part2

```lua
=LET(
    left, CHOOSECOLS(input, 1),
    right, CHOOSECOLS(input, 2),
    right_unique, UNIQUE(right),

    counts, MAP(right_unique, LAMBDA(u, SUM(--(right=u)))),
    occurances, HSTACK(right_unique, counts),

    paired, IFNA(VLOOKUP(left, occurances, 2, FALSE), 0),
    SUM(left * paired)
)
```