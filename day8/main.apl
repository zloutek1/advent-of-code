⎕IO ← 0

smallerprefix ← {⍺←⍬ ⋄ 1≡≢⍵:⊃∧/(<∘⍵)¨⍺ ⋄ (∧/(<∘(⊃⍵))¨⍺),(⍺,⊃⍵)∇(1↓⍵)}
side ← {⍉↑smallerprefix¨,⌿⍵}


part1 ← {+/+/⊃ {a b c d ← ⍵ ⋄ ∨/ a (⍉b) (⊖c) (⍉⊖d)} side¨ {⍵ (⍉⍵) (⊖⍵) (⊖⍉⍵)} ⍎¨↑ ⍵}
part2 ← 1


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⍝ ⎕ ← part2 data
