/- Project Euler Problem 1: Multiples of 3 and 5

If we list all the natural numbers below 10 that are multiples of 3 or 5,
we get 3, 5, 6 and 9.  The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.
 -/

-- Using the Unicode ℕ symbol (requires import)
import Mathlib.Data.Nat.Notation


def sumMultiples (n : ℕ) : ℕ :=
  List.range n
  |> List.filter (fun x => x % 3 == 0 || x % 5 == 0)
  |> List.sum

#eval sumMultiples 1_000 -- 233168

#eval((List.range 1_000).filter (fun x => x % 3 == 0 || x % 5 == 0)).sum
-- 233168

-- example : problem1Numbers 10 = [0, 3, 5, 6, 9] := by native_decide

-- example : problem1Answer = 233168 := by native_decide

-- end ProjectEuler

example : (List.range 10).filter (fun x => decide (x % 3 == 0) || decide (x % 5 == 0))
  = [0, 3, 5, 6, 9] := by decide

example : (List.range 10).filter (fun x => x % 3 == 0 || x % 5 == 0)
  = [0, 3, 5, 6, 9] := by decide

example : sumMultiples 10 = 23 := by native_decide
