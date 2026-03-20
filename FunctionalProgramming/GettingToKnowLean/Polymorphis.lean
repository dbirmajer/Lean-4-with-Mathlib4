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


