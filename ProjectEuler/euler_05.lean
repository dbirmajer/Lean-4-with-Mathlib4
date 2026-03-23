/- Project Euler Problem 5: Smallest multiple
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
 -/

-- Using the Unicode ℕ symbol (requires import)
import Mathlib.Data.Nat.Notation

def smallestMultiple (n : ℕ) : ℕ :=
  List.range' 1 (n + 1)
  |> List.foldl Nat.lcm 1

example : smallestMultiple 20 = 232792560 := by decide
