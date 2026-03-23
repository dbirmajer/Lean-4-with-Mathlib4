/- Project Euler Problem 10: Summation of primes
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
Find the sum of all the primes below two million.
-/




/-
import Mathlib.Data.Nat.Notation
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Stream.Defs
-- import streamsHelper

partial def takeWhile (s : Stream' α) (p : α -> Bool) (accum : List α := []): List α :=
  let x  := s.head
  if p x then takeWhile (s.tail) p (x :: accum) else accum

/-- Finds the next prime strictly greater than n -/
partial def nextPrime (n : Nat) : Nat :=
  let candidate := n + 1
  if candidate.Prime then candidate else nextPrime candidate


/-- Correct way to define primeStream as a function Nat → Nat -/
def primeStream : Stream' ℕ
  | 0     => 2
  | n + 1 => nextPrime (primeStream n)


-- Test the output

--def sol := takeWhile primeStream (· < 2_000_000) |>.sum
def sol := takeWhile primeStream (· < 2_000_000) |>.sum

#eval sol

--example : sol = 1429138289 := by native_decide
-/

import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Finset.Basic
--open scoped BigOperators

def sumPrimesBelow (n : Nat) : Finset Nat :=
  (Finset.range n).filter Nat.Prime -- or `Nat.Prime` predicate


#eval (sumPrimesBelow 10) -- 1429138289
