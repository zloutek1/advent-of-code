# Day 6

## Part 1

```lua
=BYROW(A2#, LAMBDA(row,
      LET(t, INDEX(row, 1),
            d, INDEX(row, 2),
            opts, SEQUENCE(t - 1),
            speeds, t - opts,
            final_dists, speeds * opts,
            SUM((final_dists > d) * 1)
      )
))
```