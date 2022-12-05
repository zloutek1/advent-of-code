⎕IO ← 0


parse ← {
    cr mo ← {⍵⊆⍨0≠≢¨⍵} ⍵
    crates ← {⍵/⍨' '≠⍵}¨↓⍉↑{1⌷⍉(4÷⍨1+≢⍵) 4⍴⍵}¨ cr
    moves ← {(-∘1@1 2) ⍎¨ 1⌷⍉3 2⍴⍵⊆⍨' '≠⍵}¨ mo
    (crates moves)
}

pop ← {amount pos ← ⍺ ⋄ (amount↑ pos⊃ ⍵) (((⊂ amount↓ pos⊃ ⍵)@pos) ⍵) }
push ← {items pos ← ⍺ ⋄ ((⊂ items, pos⊃ ⍵)@pos) ⍵}

move ← {
    amount from to ← ⍺ 
    items rest ← (amount from) pop ⍵
    (⍺⍺ items) to push rest
}

part1 ← {crates moves ← parse ⍵ ⋄ ⊃¨ {⍺ ← crates ⋄ 0=≢⍵: ⍺ ⋄ ((⊃⍵) ⌽move ⍺)∇(1↓⍵)} moves}
part2 ← {crates moves ← parse ⍵ ⋄ ⊃¨ {⍺ ← crates ⋄ 0=≢⍵: ⍺ ⋄ ((⊃⍵) ⊢move ⍺)∇(1↓⍵)} moves}


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⎕ ← part2 data