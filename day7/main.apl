⎕IO ← 0


shift ← {(⊃1↑⍵) (1↓⍵)}
filter ← ('cd .+|\d+'⎕S'&')
cd ← {sub xs←⍬ parse ⍵ ⋄ 0≡≢xs:(⍺,⊂sub)⍬ ⋄ (⍺,⊂sub)parse xs}
parse ← {⍺←⍬ ⋄ x xs←shift ⍵ ⋄ 0≡≢xs:(⍺,1⍴⍎x)⍬ ⋄ '.'∊x:⍺ xs ⋄ 'c'∊x:⍺ cd xs ⋄ (⍺,1⍴⍎x)∇xs}


foldfind ← {⍬≡⍴⍵: ⍵ 0 ⋄ ∧/(⍬≡⍴)¨⍵: ⍺⍺ {s←+/⍵ ⋄ ⍺⍺ s: s s ⋄ s 0}⍵ ⋄ val ret ← ↓⍉↑∇¨⍵ ⋄ val (,/ret)}
find ← {sub sum ← ⍺⍺ foldfind ⍵ ⋄ ⍬≡⍴sub: sum ⋄ ∊sum,∇sub}

du ← {∧/(⍬≡⍴)¨⍵: +/⍵ ⋄ ∇¨⍵}
tofree ← {unused ← 70000000 - du⍣{⍬≡⍴⍵} ⍵ ⋄ 30000000-unused}


part1 ← +/∘ {(100000∘≥) find ⍵} ∘ parse ∘ filter
part2 ← {0≡⍺: ⍵ ⋄ ⍺⌊⍵}/∘ {(tofree ⍵)∘≤ find ⍵} ∘ parse ∘ filter


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data
