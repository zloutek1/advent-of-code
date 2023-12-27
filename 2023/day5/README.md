# day5

## Part 1

```lua
=LET(seeds, TRANSPOSE(INT(DROP(TEXTSPLIT(A2, " ", ": "), 1))),
         steps,  DROP($A$2#, 1),
         REDUCE(seeds, steps, LAMBDA(xs,step,
              BYROW(xs, LAMBDA(source_value,
                        LET(map, INT(DROP(TEXTSPLIT(step," ",CHAR(10)), 1)),
                               matching_row_mask, BYROW(map, LAMBDA(row,
                                    LET(source, INDEX(row, 2),
                                           range, INDEX(row, 3),
                                           AND(source <= source_value, source_value <= source + range - 1)))),
                               matching_row, CHOOSEROWS(map, MATCH(TRUE, matching_row_mask, 0)),
                               dest, INDEX(matching_row, 1),
                               source, INDEX(matching_row, 2),
                               IFNA(dest + source_value - source, source_value)))
              ))
         ))
```