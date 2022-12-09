⎕IO ← 0

moves ← ↑('U' (0 1))('D' (0 ¯1))('L' (¯1 0))('R' (1 0))
todir ← {((0⌷⍉moves)⍳⍵) 1⌷moves}
parse ← {a b←⍵⋄(⊃todir a) (⍎b)}¨ ' '∘(≠⊆⊢)¨
future ← {dir by ← ⍵ ⋄ by/⊂dir}¨

parts ← /∘(⊂0 0)
move_toward ← {∧/1≥|⍵-⍺: ⍺ ⋄ ⍺+ ×¨ ⍵-⍺}
forward_body ← {acc x ← ⍵ ⋄ next ← ⍺ move_toward x ⋄ ((⊂next),acc) next}
move ← { next ← (⍵+⊃¯1↑⍺) ⋄ (⊂next),⍨ ⊃⊃forward_body/ (¯1↓⍺),(⊂⍬ next)}

eval_future ← {⊃{a b←⍵ ⋄ r←b move ⍺ ⋄ (a,⊂⊃r) r}/ (⊂⍬ (⍺)),⍨ ⍵}
eval ← {⊃ {a b ← ⍵ ⋄ r ← b eval_future ⍺ ⋄ (a,⊃r) (1⊃r)}/ (⌽⍵),(⊂⍬ (⍺))}


part1 ← {≢∪⊃ ((parts  2)∘eval) future parse ⍵}
part2 ← {≢∪⊃ ((parts 10)∘eval) future parse ⍵}


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data