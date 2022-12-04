⎕IO ← 0


split ← {⍵⊆⍨⍺≠⍵}
parse ← {⍎¨¨ '-'split¨ ','split ⍵}
part1 ← +/ {(≢>{⍵⍳((⊃⌈⌿),(1⊃⌊⌿))⍵}) ↑ parse ⍵}¨
part2 ← +/ {((⊃⌈⌿)≤(1⊃⌊⌿)) ↑ parse ⍵}¨


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data