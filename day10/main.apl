⎕IO ← 0

parse ← {↓⍉{' '∊⍵:0⋄⍎⍵}¨@1 ⍉↑' '(≠⊆⊢)¨⍵}


cycle ← {r t x←⍺ ⋄ 0≡40|20-⍨t:(r,⊂t×x)(1+t)(x+1⊃⍵) ⋄ r(1+t)(x+1⊃⍵)} 
cycle2 ← {r p x←⍺ ⋄ 1≥|¯1+(40|p)-x: (r,'x')(1+p)(x+1⊃⍵) ⋄ (r,'.')(1+p)(x+1⊃⍵)} 

step ← {'noop'≡⊃⍵: ⍺ ⍺⍺ ⍵ ⋄ (⍺ ⍺⍺ ('noop' 0)) ⍺⍺ ⍵}
exec ← {⊃⊃ ⍺⍺ step⍨/ ,∘(⊂⍬ 1 1) ⌽ ⍵}

part1 ← +/∘ (cycle exec) ∘ parse
part2 ← 6 40∘⍴ (cycle2 exec) ∘ parse


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data