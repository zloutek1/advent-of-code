⎕IO ← 0

cycle ← {r t x←⍺ ⋄ 0≡40|20-⍨t:(r,⊂t×x)(1+t)(x+1⊃⍵) ⋄ r(1+t)(x+1⊃⍵)} 
addx ← {(⍺ cycle ('noop' 0)) cycle ⍵}
noop ← cycle
exec ← {'noop'≡⊃⍵: ⍺ noop ⍵ ⋄ ⍺ addx ⍵}


cycle2 ← {r p x←⍺ ⋄ 1≥|¯1+(40|p)-x: (r,'x')(1+p)(x+1⊃⍵) ⋄ (r,'.')(1+p)(x+1⊃⍵)} 
addx2 ← {(⍺ cycle2 ('noop' 0)) cycle2 ⍵}
noop2 ← cycle2
exec2 ← {'noop'≡⊃⍵: ⍺ noop2 ⍵ ⋄ ⍺ addx2 ⍵}


parse ← {↓⍉{' '∊⍵:0⋄⍎⍵}¨@1 ⍉↑' '(≠⊆⊢)¨⍵}

part1 ← +/∘ {⊃⊃ exec⍨/ ,∘(⊂⍬ 1 1) ⌽ ⍵} ∘ parse
part2 ← 6 40∘⍴ {⊃⊃ exec2⍨/ ,∘(⊂⍬ 1 1) ⌽ ⍵} ∘ parse


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data