
# Day 11

## Part 1

```lua
=LET(y_coords, LET(coords, TOCOL((A2#="#") * (ROW(A2#) - 1)), FILTER(coords, coords<>0)),
         x_coords, LET(coords, TOCOL((A2#="#") * COLUMN(A2#)), FILTER(coords, coords<>0)),
         galaxy_coords, CHOOSE({1,2}, y_coords, x_coords),
         empty_rows, LET(coords, TRANSPOSE(BYROW(A2#, LAMBDA(row,
                                                    (SUBSTITUTE(CONCAT(row), ".", "") = "") * (ROW(row) - 1)))),
                                      FILTER(coords, coords<>0)),
         empty_cols, LET(coords, BYCOL(A2#, LAMBDA(col,
                                                    (SUBSTITUTE(CONCAT(col), ".", "") = "") * COLUMN(col))),
                                     FILTER(coords, coords<>0)),
         pairs, LET(
             galaxies, ROWS(galaxy_coords),
             indexes, SEQUENCE(galaxies),
             matrix, SEQUENCE(galaxies * galaxies, 1, 0),
             first_indexes, MOD(matrix, galaxies) + 1,
             second_indexes, INT(matrix / galaxies) + 1,
             result, INDEX(indexes, first_indexes) & ", " & INDEX(indexes, second_indexes),
             FILTER(result, first_indexes < second_indexes)),
        distance, MAP(pairs, LAMBDA(pair,
            LET(pair_split, INT(TEXTSPLIT(pair, ", ")),
                   first_galaxy, CHOOSEROWS(galaxy_coords, INDEX(pair_split, 1)),
                   seconds_galaxy, CHOOSEROWS(galaxy_coords, INDEX(pair_split, 2)),
                   manhattan, SUM(ABS(first_galaxy - seconds_galaxy)),
                   expanded_rows, LET(first, INDEX(first_galaxy, 1), second, INDEX(seconds_galaxy, 1), SUM((first < empty_rows) * (empty_rows < second)) + SUM((second < empty_rows) * (empty_rows < first))),
                   expanded_cols, LET(first, INDEX(first_galaxy, 2), second, INDEX(seconds_galaxy, 2), SUM((first < empty_cols) * (empty_cols < second)) + SUM((second < empty_cols) * (empty_cols < first))),
                   result, manhattan + expanded_cols + expanded_rows,
                   result))),
        SUM(distance)
)
```