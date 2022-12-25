⎕IO ← 0


parse ← {
    c m ← {⍵⊆⍨0≠≢¨⍵} ⍵
    c ← {⍵/⍨' '≠⍵}¨↓⍉↑{1⌷⍉(4÷⍨1+≢⍵) 4⍴⍵}¨ c
    m ← ⌽{(-∘1@1 2) ⍎¨ 1⌷⍉3 2⍴⍵⊆⍨' '≠⍵}¨ m
    m,⊂c
}

pop ← {k pos ← ⍺ ⋄ (k↑ pos⊃ ⍵) (((⊂ k↓ pos⊃ ⍵)@pos) ⍵) }
push ← {x pos ← ⍺ ⋄ ((⊂ x, pos⊃ ⍵)@pos) ⍵}
move ← {k from to ← ⍺ ⋄ x xs ← (k from) pop ⍵ ⋄ (⍺⍺ x) to push xs }

part1 ← {⊃¨⊃ ⌽move/ parse ⍵}
part2 ← {⊃¨⊃ ⊢move/ parse ⍵}


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data