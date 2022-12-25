⎕IO ← 0


parse ← (',-'∘(⍎¨(~∊⍨)⊆⊢))
part1 ← +/ {a b c d ← parse ⍵ ⋄ 0≥(a-c)×(b-d)}¨
part2 ← +/ {a b c d ← parse ⍵ ⋄ 0≥(a-d)×(b-c)}¨


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data