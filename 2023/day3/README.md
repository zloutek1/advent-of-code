
# day 3

## part 1

```lua
'=LET(first_touch, MAP(B3#, LAMBDA(cell,
                 LET(box,OFFSET(cell,-1,-1,3,3),
                        mask, (box<>".") * (ISERROR(INT(box)) * (box<>"")),
                        IF(OR(mask) * ISNUMBER(INT(cell)), 1, ".")))),
          concat_values, CONCAT(IFERROR(B3#+0,".")),
          explode_values, IFERROR(INT(MID(concat_values, SEQUENCE(LEN(concat_values)), 1)), "."),
          explode_mask, IFERROR(INT(MID(CONCAT(first_touch), SEQUENCE(LEN(CONCAT(first_touch))), 1)), "."),
          mask, REDUCE(explode_mask, SEQUENCE(4), LAMBDA(arr,_,
                 LET(indexes, SEQUENCE(ROWS(arr)),
                        MAP(indexes, LAMBDA(i, LET(
                             value, INDEX(explode_values, i),
                             above, INDEX(arr, i),
                             left, IF(i-1 > 0, INDEX(arr, i-1), 999),
                             right, IF(i+1 < ROWS(arr), INDEX(arr, i+1), 999),
                             IF((value<>".") * OR(left=1, right=1, above), 1, ".")
                 ))))
          )),
          digits, IFERROR(IF(mask, explode_values), "."),
          numbers, TEXTSPLIT(CONCAT(digits), "."),
          INT(FILTER(numbers, numbers<>""))
)							
```