⎕IO ← 0
⎕PP←20

parse_monkey ← {('old|[*+]|\d+'⎕S'&'¨)@1⊢ ⊃¨@2 3 4 (⍎¨¨ '\d+'⎕S'&'¨)@0 2 3 4⊢ ⍵}
parse ← {↑ parse_monkey¨ 1↓¨ (×∘≢¨⊆⊢) ⍵}

val ← {'old'≡⍺: ⍵ ⋄ ⍎⍺}
eval ← {l o r ← ⍺ ⋄ l ← l val ⍵ ⋄ r ← r val ⍵ ⋄ '+'∊o: l+r ⋄ l×r}

i ← ⍬
pop ← {⊂1↓⊃⍵}@0
push ← {⊂⍺,⍨⊃⍵}@0
throw_to ← {st cmd cond t f ← ⍵ ⋄ it ← (⍺⍺ cmd eval ⊃st) ⋄ 0≡cond|it: t it ⋄ f it}
throw ← {⍬≡⊃⍺⌷⍵: ⍵ ⋄ i +← 1@⍺⊢ (≢⍵)/0 ⋄ m it←⍺⍺ throw_to ⍺⌷⍵ ⋄ it∘push@m ⊢ pop@⍺⊢⍵}
round ← {⊃⍺⍺ {m ← ⍺ ⋄ ⍺⍺ {m ⍺⍺ throw ⍵}⍣{⍬≡⊃m⌷⍺}⊢⍵}/ (⌽⍳≢⍵),⊂⍵}

part1 ← {i ⊢← (≢⍵)/0 ⋄ ×/2↑i[⍒i]⊣ ({(⌊÷∘3) round ⍵}⍣20⊢⍵)} ∘ parse
part2 ← {i ⊢← (≢⍵)/0 ⋄ ×/2↑i[⍒i]⊣ ({((∧/2⌷[1]⍵)∘|) round ⍵}⍣1e4⊢⍵)} ∘ parse


argv ← ⊢2⎕NQ#'GetCommandLineArgs'
data ← ⊃⎕NGET (1⊃argv)1
⎕ ← part1 data
⎕ ← part2 data