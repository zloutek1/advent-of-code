⎕IO ← 0

prefix ← {∧/¨ ⍵> ↑∘⍵¨ ⍳≢⍵}
side ← {⍉↑prefix¨,⌿⍵}

rot ← {(⌽∘⍉)⍣⍺⊢⍵}

mask ← {n←¯2+≢⍵ ⋄ 1+⍸n n⍴1}
count_trees ← {⍬≡⍺:0 ⋄ (0≡⍺)∨(0≡⍵):1+⍺ ⋄ ⍺+⍵}
directions ← {x y ← ⍺ ⋄ (⌽y↑x⌷[1]⍵) (⌽x↑y⌷⍵) ((1+x)↓y⌷⍵) ((1+y)↓x⌷[1]⍵)}
view ← {x y ← ⍺ ⋄ ×/ count_trees/¨ {⍵≡⍬: 0 0 ⋄ ⍵}¨ <∘((y x)⌷⍵)¨ ⍺ directions ⍵}

part1 ← {+/+/⊃∨/ {(-⍳4) rot¨ ⍵} side¨ {(⍳4) ∘.rot ⊂⍵} ⍎¨↑ ⍵}
part2 ← {⌈/ view∘⍵¨ mask ⍵} (⍎¨↑) 


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data
