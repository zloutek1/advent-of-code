⎕IO ← 0
assert ← {⍺ ← 'assertion failure' ⋄ 0 ∊ ⍵: ⍺ ⎕signal 8 ⋄ shy ← 0}

map ← ↑((0 2) (1 0) (2 1))((0 0) (1 1) (2 2))((0 1) (1 2) (2 0))

part1 ← {+/ {{⍵[1] + {⍵[0]=⍵[1]:3 ⋄ (⍵[0]+1)=⍵[1]:6 ⋄ (⍵[0]-2)=⍵[1]:6 ⋄ 0} ⍵} {(1+'ABC'⍳⍵[0]) (1+'XYZ'⍳⍵[2])} ⍵}¨ ⍵}
part2 ← {+/ {col ← (⎕UCS 'A') -⍨ (⎕UCS ⍵[0]) ⋄ row ←  (⎕UCS 'X') -⍨ (⎕UCS ⍵[2]) ⋄ (3×row)+(1+1⌷⊃map[row;col])}¨ ⍵}


⍝ --- data ---
⍝ data ← ⊃⎕NGET'./input.txt'1
⍝ ⎕ ← part1 data
⍝ ⎕ ← part2 data


⍝ --- tests ---
test_data ← ⊃⎕NGET'./example.txt'1
stars ← '××'

assert 15 ≡ part1 test_data
(1↑stars) ← '*'

assert 12 ≡ part2 test_data
(2↑stars) ← '**'

⎕ ← stars
