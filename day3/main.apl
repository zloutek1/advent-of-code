⎕IO ← 0


priority ← 1+ ((⎕C,⊢)⎕A)∘ ⍳
part1 ← +/ {priority ⊃¨ ∩/ ↓ {2 (2÷⍨≢⍵)⍴⍵} ⍵}¨
part2 ← +/ {priority ⊃¨ ∩/ {(3÷⍨≢⍵) 3⍴⍵} ⍵}


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data