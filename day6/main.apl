⎕IO ← 0


find_unique ← {⍺+ ⍺⍳⍨ ≢¨ ⍺∪/ ⍵}
part1 ← 4∘find_unique
part2 ← 14∘find_unique


data ← ⊃⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data