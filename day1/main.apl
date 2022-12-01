⎕IO ← 0
assert ← {⍺ ← 'assertion failure' ⋄ 0 ∊ ⍵: ⍺ ⎕signal 8 ⋄ shy ← 0}


part1 ← {⌈/ +/¨ {⍎¨⍵}¨ 1↓¨ ((0=≢¨)⊂⊢) (⊂0⍴1), ⍵}
part2 ← {+/ 3↑ array[⍒array ← +/¨ {⍎¨⍵}¨ 1↓¨ ((0=≢¨)⊂⊢) (⊂0⍴1), ⍵]}


⍝ --- data ---
⍝ data ← ⊃⎕NGET'./input.txt'1
⍝ ⎕ ← part1 data
⍝ ⎕ ← part2 data


⍝ --- tests ---
test_data ← ⊃⎕NGET'./example.txt'1
stars ← '××'

assert 24000 ≡ (part1 test_data)
(1↑stars) ← '*'

assert 45000 ≡ (part2 test_data)
(2↑stars) ← '**'

⎕ ← stars
