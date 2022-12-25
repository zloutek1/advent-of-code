⎕IO ← 0


part1 ← {⌈/ +/¨ {⍎¨⍵}¨ 1↓¨ ((0=≢¨)⊂⊢) (⊂0⍴1), ⍵}
part2 ← {+/ 3↑ array[⍒array ← +/¨ {⍎¨⍵}¨ 1↓¨ ((0=≢¨)⊂⊢) (⊂0⍴1), ⍵]}


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data