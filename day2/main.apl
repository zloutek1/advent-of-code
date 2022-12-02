⎕IO ← 0
assert ← {⍺ ← 'assertion failure' ⋄ 0 ∊ ⍵: ⍺ ⎕signal 8 ⋄ shy ← 0}

map ← ↑((0 2) (1 0) (2 1))((0 0) (1 1) (2 2))((0 1) (1 2) (2 0))

convert_row ← {(65-⍨⎕UCS ⍵[0]) (88-⍨⎕UCS ⍵[2])}
part1 ← +/ {{(3×⍵[0])+(1+1⌷⊃⍵⌷map)} ⊃⍸ map⍷⍨ ⊂convert_row ⍵}¨
part2 ← +/ {pos ← convert_row ⍵ ⋄ (3×pos[1])+(1+1⌷⊃pos⌷map)}¨


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
