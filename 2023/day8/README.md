
# Day 8

## Part 1

```lua
'NextStep(inp, step)
=LAMBDA(inp,step, 
      LET(pattern, INDEX(Part1!$A$2#, 1, 1), 
             dir, MID(pattern, MOD(step - 1, LEN(pattern))+1, 1), 
             map,DROP(Part1!$A$2#,2),
              VLOOKUP(inp,map,2+(dir="R")*1,FALSE)) )
```

```lua
=REDUCE("AAA", SEQUENCE(20000), LAMBDA(x,step,
      LET(next, NextStep(x, step),
             IF(ISNUMBER(x), x,
             IF(next="ZZZ", step,
                 next)))
      ))
```