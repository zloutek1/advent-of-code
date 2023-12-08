# Day 2

## Part 1

```code
=LET(source, IFERROR(TEXTSPLIT(A4, "": ""), """"),
         id, INT(SUBSTITUTE(CHOOSECOLS(source, 1), ""Game "", """")),
         source_data, TEXTSPLIT(INDEX(CHOOSECOLS(source, 2), 1), ""; ""),
         extract_count,LAMBDA(str,
           LET(data,TEXTSPLIT(str,"" "","", ""),
                  count,INT(CHOOSECOLS(data,1)),
                  colors,CHOOSECOLS(data,2),
                  colors_pos,MATCH({""red"";""green"";""blue""},colors,0),
                  IFNA(INDEX(count,colors_pos),0)
           )),
         combined,REDUCE({0;0;0}, source_data, LAMBDA(acc,str,HSTACK(acc,extract_count(str)))),
         max_counts, BYROW(combined,LAMBDA(row,MAX(row))),
         is_possible, AND(INDEX(max_counts<=$F$2#, SEQUENCE(3), SEQUENCE(3))),
         IFERROR(is_possible * id, """")
)
```

## Part 2
```code
=LET(source, IFERROR(TEXTSPLIT(A4, "": ""), """"),
         id, INT(SUBSTITUTE(CHOOSECOLS(source, 1), ""Game "", """")),
         source_data, TEXTSPLIT(INDEX(CHOOSECOLS(source, 2), 1), ""; ""),
         extract_count,LAMBDA(str,
           LET(data,TEXTSPLIT(str,"" "","", ""),
                  count,INT(CHOOSECOLS(data,1)),
                  colors,CHOOSECOLS(data,2),
                  colors_pos,MATCH({""red"";""green"";""blue""},colors,0),
                  IFNA(INDEX(count,colors_pos),0)
           )),
         combined,REDUCE({0;0;0}, source_data, LAMBDA(acc,str,HSTACK(acc,extract_count(str)))),
         max_counts, BYROW(combined,LAMBDA(row,MAX(row))),
         IFERROR(PRODUCT(max_counts), """")
)
```