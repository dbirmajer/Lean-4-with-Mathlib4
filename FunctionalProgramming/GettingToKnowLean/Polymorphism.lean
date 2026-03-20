import Mathlib.Data.Nat.Notation

-- 1.6. Polymorphism

structure PPoint (α : Type) where
  x : α
  y : α

def originPPoint : PPoint ℕ :=
   { x := 0, y := 0 }

def replaceX (α : Type) (p : PPoint α) (newX : α) : PPoint α :=
  { p with x := newX }

#check replaceX

#check replaceX ℕ

#check replaceX ℕ originPPoint

#eval replaceX ℕ originPPoint 5

inductive Sign where
  | pos
  | neg

def posOrNegThree (s: Sign) :
  match s with | Sign.pos => ℕ | Sign.neg => Int :=
  match s with
  | Sign.pos => 3
  | Sign.neg => -3

#eval posOrNegThree Sign.pos -- 3
#eval posOrNegThree Sign.neg -- -3

-- 1.6.1 Linked Lists

#eval List.length [1, 2, 3] -- 3
#eval List.length ["a", "b", "c", "d"] -- 4

-- 1.6.2 Implcit Arguments

def length {α : Type} (xs : List α) : Nat :=
  match xs with
  | [] => 0
  | _ :: ys => Nat.succ (length ys)

#eval length [1, 2, 3] -- 3
#eval length ["a", "b", "c", "d"] -- 4

-- 1.6.3. More Built-In Datatypes

inductive Firewood where
  | birch
  | pine
  | beech
deriving Repr

#check Firewood.beech

def allFirewood : List Firewood := [Firewood.birch, Firewood.pine, Firewood.beech]

#eval allFirewood

-- 1.6.5 Exercises


-- Write a function to find the last entry in a list.
-- It should return an Option.
 def last {α : Type} (xs : List α) : Option α :=
  match xs with
  | [] => none
  | [x] => some x
  | _ :: ys => last ys

  #eval last [1, 2, 3] -- some 3

-- Write a function that finds the first entry in a list that satisfies a given predicate.
-- Start the definition with
-- def List.findFirst? {α : Type} (xs : List α) (predicate : α → Bool) : Option α := ….
def List.findFirst? {α : Type} (xs : List α) (predicate : α → Bool) : Option α :=
  match xs with
  | [] => none
  | x :: ys => if predicate x then some x else List.findFirst? ys predicate


-- Write a function Prod.switch that switches the two fields in a pair for each other.
-- Start the definition with def Prod.switch {α β : Type} (pair : α × β) : β × α := ….
def Prod.switch {α β : Type} (pair : α × β) : β × α :=
  (pair.snd, pair.fst)

#eval Prod.switch ("hello", 42) -- (42, "hello")


-- Rewrite the PetName example to use a custom datatype and compare it to the version that uses Sum.

inductive PetName where
  | dogName : String → PetName
  | catName : String → PetName
deriving Repr

def pets : List PetName :=
  [PetName.dogName "Rover", PetName.catName "Whiskers", PetName.dogName "Fido"]

#eval pets

#check PetName.dogName
#check PetName

-- Write a function zip that combines two lists into a list of pairs. The resulting list should be as long as the shortest input list.
-- Start the definition with def zip {α β : Type} (xs : List α) (ys : List β) : List (α × β) := ….

def zip {α β : Type} (xs : List α) (ys : List β) : List (α × β) :=
  match xs, ys with
  | [], _ => []
  | _, [] => []
  | x :: xs', y :: ys' => (x, y) :: zip xs' ys'

example: zip [1, 2, 3] ["a", "b"] = [(1, "a"), (2, "b")] := by decide

/-

Write a polymorphic function take that returns the first
n entries in a list, where n is a Nat.
If the list contains fewer than n entries, then the resulting list should be the
-- entire input list.
-- #eval take 3 ["bolete", "oyster"] should yield ["bolete", "oyster"], and
-- #eval take 1 ["bolete", "oyster"] should yield ["bolete"].

-/

def take {α : Type} (n : Nat) (xs : List α) : List α :=
  match n, xs with
  | 0, _ => []
  | _, [] => []
  | _, x :: xs' => x :: take (n - 1) xs'


-- Using the analogy between types and arithmetic, write a function that
-- distributes products over sums.
-- In other words, it should have type α × (β ⊕ γ) → (α × β) ⊕ (α × γ).

def distribute {α β γ : Type} (x : α) (s : β ⊕ γ) : (α × β) ⊕ (α × γ) :=
  match s with
  | Sum.inl b => Sum.inl (x, b)
  | Sum.inr c => Sum.inr (x, c)

def distribute' {α β γ : Type} (s : α × (β ⊕ γ)) : (α × β) ⊕ (α × γ) :=
  match s with
  | (x, Sum.inl b) => Sum.inl (x, b)
  | (x, Sum.inr c) => Sum.inr (x, c)



-- Using the analogy between types and arithmetic, write a function that turns
-- multiplication by two into a sum. In other words, it should have type
-- Bool × α → α ⊕ α.

def distributeBool {α : Type} (b : Bool) (x : α) : α ⊕ α :=
  if b then Sum.inl x else Sum.inr x
