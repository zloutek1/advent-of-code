⎕IO ← 0

moves ← ↑('U' (0 1))('D' (0 ¯1))('L' (¯1 0))('R' (1 0))
todir ← {((0⌷⍉moves)⍳⍵) 1⌷moves}
parse ← {a b←⍵⋄(⊃todir a) (⍎b)}¨ ' '∘(≠⊆⊢)¨

⍝ :(
sgn ← {⍵<0:¯1 ⋄ ⍵>0:1 ⋄ 0}
move_toward ← {∧/1≥|⍵-⍺: ⍺ ⋄ ⍺+ sgn¨ ⍵-⍺}

move ← {dir by ← ⍵ ⋄ (⍺+dir∘×)¨ 1+⍳by}
head_moves ← {⍺ ← (0 0) ⋄ res ← ⍺ move (⊃⍵) ⋄ 1≡≢⍵: res ⋄ res,(⊃¯1↑res)∇(1↓⍵)}

tail_moves ← {⍺←(0 0) ⋄ x xs ← (⊃⍵) (1↓⍵) ⋄ 0≡≢⍵: ⍬ ⋄ ∧/1≥|⍺-x: (⊂⍺),⍺∇xs ⋄ tail ← ⍺ move_toward x ⋄ (⊂tail),tail∇xs}


part1 ←  {≢∪ tail_moves head_moves parse ⍵}
part2 ← ⊢∘2


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data
