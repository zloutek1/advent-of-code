⎕IO ← 0

addx ← {r t x←⍺ ⋄ 0≡40|20-⍨1+t:(r,⊂(1+t)×x)(2+t)(x+1⊃⍵) ⋄ 0≡40|20-⍨t:(r,⊂t×x)(2+t)(x+1⊃⍵) ⋄ r(2+t)(x+1⊃⍵)}
noop ← {r t x←⍺ ⋄                                         0≡40|20-⍨t:(r,⊂t×x)(1+t)(x+1⊃⍵) ⋄ r(1+t)(x+1⊃⍵)}
exec ← {'noop'≡⊃⍵: ⍺ noop ⍵ ⋄ ⍺ addx ⍵}
run ← {⊃⊃ exec⍨/ ,∘(⊂⍬ 1 1) ⌽ ⍵}

parse ← {↓⍉{' '∊⍵:0⋄⍎⍵}¨@1 ⍉↑' '(≠⊆⊢)¨⍵}

part1 ← +/∘ run ∘ parse
part2 ← 1


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⍝ ⎕ ← part2 data