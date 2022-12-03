⎕IO ← 0
assert ← {⍺ ← 'assertion failure' ⋄ 0 ∊ ⍵: ⍺ ⎕signal 8 ⋄ shy ← 0}

priority ← 1+ ((819⌶⎕A),⎕A)∘ ⍳
part1 ← +/ {priority ⊃ {⍵[0;]∩⍵[1;]} {2 (2÷⍨≢⍵)⍴⍵} ⍵}¨
part2 ← +/ {priority ⊃¨ ∩/ {(3÷⍨≢⍵) 3⍴⍵} ⍵}


⍝ --- data ---
⍝ data ← ⊃⎕NGET'./input.txt'1
⍝ ⎕ ← part1 data
⍝ ⎕ ← part2 data


⍝ --- tests ---
test_data ← ⊃⎕NGET'./example.txt'1
stars ← '××'

assert 157 ≡ part1 test_data
(1↑stars) ← '*'

assert 70 ≡ part2 test_data
(2↑stars) ← '**'

⎕ ← stars
