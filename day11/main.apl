⎕IO ← 0
⎕PP←20

parse_monkey ← {0,⍨ ('old|[*+]|\d+'⎕S'&'¨)@1⊢ ⊃¨@2 3 4 (⍎¨¨ '\d+'⎕S'&'¨)@0 2 3 4⊢ ⍵}
parse ← {↑ parse_monkey¨ 1↓¨ (×∘≢¨⊆⊢) ⍵}

val ← {'old'≡⍺: ⍵ ⋄ ⍎⍺}
eval ← {l o r ← ⍺ ⋄ l ← l val ⍵ ⋄ r ← r val ⍵ ⋄ '+'∊o: l+r ⋄ l×r}

inc ← 1∘+@5
pop ← {⊂1↓⊃⍵}@0
push ← {⊂⍺,⍨⊃⍵}@0
throw_to ← {st cmd cond t f c ← ⍵ ⋄ it ← (⍺⍺ cmd eval ⊃st) ⋄ 0≡cond|it: t it ⋄ f it}
throw ← {⍬≡⊃⍺⌷⍵: ⍵ ⋄ m it←⍺⍺ throw_to ⍺⌷⍵ ⋄ inc@⍺⊢ it∘push@m ⊢ pop@⍺⊢⍵}
round ← {⊃⍺⍺ {m ← ⍺ ⋄ ⍺⍺ {m ⍺⍺ throw ⍵}⍣{⍬≡⊃m⌷⍺}⊢⍵}/ (⌽⍳≢⍵),⊂⍵}

part1 ← {×/{2↑⍵[⍒⍵]} 5⌷[1] ({(⌊÷∘3) round ⍵}⍣20⊢⍵)} ∘ parse
part2 ← {×/{2↑⍵[⍒⍵]} 5⌷[1] ({((∧/2⌷[1]⍵)∘|) round ⍵}⍣1e4⊢⍵)} ∘ parse


argv ← ⊢2⎕NQ#'GetCommandLineArgs'
data ← ⊃⎕NGET (1⊃argv)1
⎕ ← part1 data
⎕ ← part2 data