⎕IO ← 1

shift ← {(⊃1↑⍵) (1↓⍵)}
cd ← {
    f rest←shift ⍵
    ⎕←2 f rest
    subdir rest←(⊂f)parse rest
    0=≢rest:(⍺,⊂subdir) rest
    (⍺,⊂subdir)parse rest
}
parse ← {
    ⍺←⍬
    f rest←shift ⍵
    ⎕←1 f rest
    '$ cd /'≡f: (⍺,⊂f) ∇ rest
    '$ cd ..'≡f: ⍺ rest
    ∧/'$ cd'∊f: ⍺ cd ⍵
    '$ ls'≡f: ⍺∇rest
    0=≢rest: (⍺,⊂f) rest
    (⍺,⊂f)∇ rest
}

part1 ← {parse ⍵}
part2 ← 1


data ← ⊃⎕NGET ⍞1
⎕ ← part1 data
⍝ ⎕ ← part2 data


⍝cd ..: stop
⍝cd x:  
⍝    subdir rest2 <- 0 V rest
⍝    (a,subdir) V rest2
⍝a,cf V rest
