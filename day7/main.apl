⎕IO ← 0

shift ← {(⊃1↑⍵) (1↓⍵)}
filter ← ('cd .+|\d+'⎕S'&')
cd ← {sub xs←⍬ parse ⍵ ⋄ 0≡≢xs:(⍺,⊂sub)⍬ ⋄ (⍺,⊂sub)parse xs}
parse ← {⍺←⍬ ⋄ x xs←shift ⍵ ⋄ 0≡≢xs:(⍺,1⍴⍎x)⍬ ⋄ '.'∊x:⍺ xs ⋄ 'c'∊x:⍺ cd xs ⋄ (⍺,1⍴⍎x)∇xs}

⍝ du ← {⍺ ← 0 ⋄ x xs ← shift ⍵ ⋄ ⍬≡xs: x ⋄ x≡⊃x: ∇xs ⋄ x}
⍝ du ← ({∧/(⍬≡⍴)¨⍵: +/⍵ ⋄ ∇¨⍵}⍣1) (1 1(1 1(1 1)))
du ← {⍬≡⍴⍵: ⍵ 0 ⋄ ∧/(⍬≡⍴)¨⍵: {s←+/⍵ ⋄ 100000≥s: s s ⋄ s 0}⍵ ⋄ val ret ← ↓⍉↑∇¨⍵ ⋄ val (+/ret)}

part1 ← {sub sum ← du ⍵ ⋄ ⍬≡⍴sub: sum ⋄ sum+∇sub} ∘ parse ∘ filter
part2 ← 1


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⍝ ⎕ ← part2 data


⍝cd ..: stop
⍝cd x:  
⍝    subdir rest2 <- 0 V rest
⍝    (a,subdir) V rest2
⍝a,cf V rest
