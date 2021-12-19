
module main where

open import Data.Nat using (ℕ; suc; _*_; _+_; _∸_; _≡ᵇ_; _≥?_; _≤?_; _⊔_)
open import Data.Nat.Show using (show)
open import Function using (_∘_; _$_; _|>_; flip)
open import Data.Product using (_×_; _,_; proj₁; proj₂; uncurry)
open import Data.String as Str using (String;
                                      lines; unlines)
open import Data.List using (List; []; _∷_;
                             null; length; _++_; tail;
                             map; foldr; foldl; span; drop; partition)
open import IO as IO using (Main; run; putStrLn; readFiniteFile; _>>=_; _>>_)
open import Data.Bool using (Bool; true; false; T?;
                            if_then_else_;
                            not; _∧_; _∨_)
open import Data.Char using (Char; _≟_; _==_; toℕ)
open import Data.Maybe using (Maybe; just; nothing; maybe)
                       renaming (map to map?; _>>=_ to _>>=ᵐ_)
open import Data.List.NonEmpty as L⁺ using (List⁺; wordsBy)
open import Relation.Nullary using (yes; no)

Point = ℕ × ℕ

data Action  : Set where
    foldup   : ℕ → Action
    foldleft : ℕ → Action

{- Helper functions -}

_=<<ᵐ_ : ∀ {a} {b} {A : Set a} {B : Set b} → (A → Maybe B) → Maybe A → Maybe B
_=<<ᵐ_ = flip _>>=ᵐ_

toDigit : Char → ℕ
toDigit x = toℕ x ∸ toℕ '0'

readℕ : List Char → ℕ
readℕ = foldl (λ acc x → acc * 10 + toDigit x) 0

tuplify2 : ∀ {a} {A : Set a} → List A → Maybe (A × A)
tuplify2 (x ∷ y ∷ _) = just (x , y)
tuplify2 _           = nothing

sequence : ∀ {a} {A : Set a} → List (Maybe A) → Maybe (List A)
sequence {A = A} = foldr step (just [])
    where step : Maybe A → Maybe (List A) → Maybe (List A)
          step _        nothing   = nothing
          step nothing  _         = nothing
          step (just x) (just xs) = just $ x ∷ xs

isPrefixOf : List Char → List Char → Bool
isPrefixOf [] _ = true
isPrefixOf _ [] = false
isPrefixOf (x ∷ xs) (y ∷ ys) = (x == y) ∧ isPrefixOf xs ys

_∈_ : Point → List Point → Bool
_∈_ x           []               = false
_∈_ x@(x1 , y1) ((x2 , y2) ∷ ys) = ((x1 ≡ᵇ x2) ∧ (y1 ≡ᵇ y2)) ∨ (x ∈ ys)

nub : List Point → List Point
nub [] = []
nub (x ∷ xs) with x ∈ xs
... | true  = nub xs
... | false = x ∷ nub xs

{-# TERMINATING #-}
_⋯_ : ℕ → ℕ → List ℕ
from ⋯ to with from ≤? to
...       | yes _ = from ∷ suc from ⋯ to
...       | no  _ = []

for : ∀ {a} {b} {A : Set a} {B : Set b} → List A → (A → B) → List B
for = flip map

{- Impl -}

foldAlong : Action → Point → Point
foldAlong (foldup y)   (x1 , y1) = (x1 , 2 * y ∸ y1)
foldAlong (foldleft x) (x1 , y1) = (2 * x ∸ x1 , y1)

foldSheet : Action → List Point → List Point
foldSheet action@(foldup y)   points with partition (_≥?_ y ∘ proj₂) points
...    | (up , down)    = nub $ up   ++ map (foldAlong action) down
foldSheet action@(foldleft x) points with partition (_≥?_ x ∘ proj₁) points
...    | (left , right) = nub $ left ++ map (foldAlong action) right

part1 : List⁺ Point -> List⁺ Action -> ℕ
part1 points actions = length $ foldSheet (L⁺.head actions) (L⁺.toList points)

draw : List Point -> String
draw points =
    let width = foldr _⊔_ 0 $ map proj₁ points in
    let height = foldr _⊔_ 0 $ map proj₂ points in
    unlines $ for (0 ⋯ height) λ y →
        Str.fromList $ for (0 ⋯ width)  λ x →
        if (x , y) ∈ points then '#' else '.'

part2 : List⁺ Point → List⁺ Action → String
part2 points actions = draw $ foldl (flip foldSheet) (L⁺.toList points) (L⁺.toList actions)

{- Parse File -}

parsePoint : String → Maybe Point
parsePoint str = str
    |> Str.toList
    |> wordsBy (_==_ ',')
    |> map (readℕ ∘ L⁺.toList)
    |> tuplify2

parseAction : String → Maybe Action
parseAction str with isPrefixOf (Str.toList "fold along") $ Str.toList str
...             | true with map L⁺.toList $ wordsBy (_==_ '=') $ drop 11 $ Str.toList str
...                    | (dir ∷ value ∷ []) with dir
...                           | ('x' ∷ []) = readℕ value |> foldleft |> just
...                           | ('y' ∷ []) = readℕ value |> foldup   |> just
...                           | _          = nothing
parseAction _   | true | _ = nothing
parseAction _   | _ = nothing

parseFile : String → Maybe (List⁺ Point × List⁺ Action)
parseFile content =
    let (points , actions) = span (T? ∘ not ∘ null ∘ Str.toList) $ lines $ content in
    tail actions >>=ᵐ λ actions' →
    (points   |> map parsePoint  |> sequence) >>=ᵐ L⁺.fromList >>=ᵐ λ parsedPoints  →
    (actions' |> map parseAction |> sequence) >>=ᵐ L⁺.fromList >>=ᵐ λ parsedActions →
    just (parsedPoints , parsedActions)

{- Main -}

main : Main
main = run $ do
    content ← readFiniteFile "input.txt"
    let parsed = parseFile content
    putStrLn $ maybe (Str._++_ "[Part1] "  ∘ show ∘ uncurry part1) "[Error] Could not parse file" parsed
    putStrLn $ maybe (Str._++_ "[Part2]\n" ∘ uncurry part2)        "[Error] Could not parse file" parsed
