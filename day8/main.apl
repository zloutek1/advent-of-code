⎕IO ← 0

prefix ← {⍺←⍬ ⋄ 1≡≢⍵:⊃∧/(<∘⍵)¨⍺ ⋄ (∧/<∘(⊃⍵)¨⍺),(⍺,⊃⍵)∇(1↓⍵)}
side ← {⍉↑prefix¨,⌿⍵}

count_trees ← {⍬≡⍺:0 ⋄ (0≡⍺)∨(0≡⍵):1+⍺ ⋄ ⍺+⍵}
directions ← {x y ← ⍺ ⋄ (⌽y↑x⌷[1]⍵) (⌽x↑y⌷⍵) ((1+x)↓y⌷⍵) ((1+y)↓x⌷[1]⍵)}
view ← {x y ← ⍺ ⋄ ×/ count_trees/¨ {⍵≡⍬: 0 0 ⋄ ⍵}¨ <∘((y x)⌷⍵)¨ ⍺ directions ⍵}
mask ← {n←¯2+≢⍵ ⋄ 1+⍸n n⍴1}

part1 ← {+/+/⊃ {a b c d ← ⍵ ⋄ ∨/ a (⍉b) (⊖c) (⍉⊖d)} side¨ {⍵ (⍉⍵) (⊖⍵) (⊖⍉⍵)} ⍎¨↑ ⍵}
part2 ← {⌈/ view∘⍵¨ mask ⍵} (⍎¨↑) 


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data
