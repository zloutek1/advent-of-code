
# Day 9

## Part 1

```lua
=LET(history, TRANSPOSE(CHOOSEROWS($A$2#, ROW(1:1))),
         last_value, INDEX(history, ROWS(history)),
         last_steps, MAP(SEQUENCE(ROWS(history)), LAMBDA(n,
             LET(new_step, REDUCE(history, SEQUENCE(n), LAMBDA(x,n_,
                                           LET(step, DROP(x, 1) - x,
                                                  FILTER(step, NOT(ISNA(step))))
                                           )),
                     INDEX(new_step, ROWS(new_step)))
             )),
        IFERROR(last_value + SUM(last_steps), "")
)
```

## Part 2

```lua
=LET(history, TRANSPOSE(CHOOSEROWS($A$2#, ROW(1:1))),
         first_value, INDEX(history, 1),
         first_steps, MAP(SEQUENCE(ROWS(history)), LAMBDA(n,
             LET(new_step, REDUCE(history, SEQUENCE(n), LAMBDA(x,n_,
                                           LET(step, DROP(x, 1) - x,
                                                  FILTER(step, NOT(ISNA(step))))
                                           )),
                     INDEX(new_step, 1))
             )),
        reversed_first_steps,  SORTBY(first_steps, SEQUENCE(ROWS(first_steps)), -1),
        result, first_value - REDUCE(0, reversed_first_steps, LAMBDA(acc,x, x - acc)),
        IFERROR(result, "")
)
```