-- Using the Unicode ℕ symbol (requires import)
import Mathlib.Data.Nat.Notation

namespace ProjectEuler


-- Project Euler Problem 9: Special Pythagorean triplet
/-
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
a^2 + b^2 = c^2 For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2. There exists exactly one Pythagorean triplet for which a + b + c = 1000. Find the product abc.
-/


def findTriplet : Option (ℕ × ℕ × ℕ) :=
  List.range' 1 1001
  |> List.flatMap (fun a => List.range 500
    |> List.map (fun b => (a, b, 1000 - a - b)))
  |> List.find? (fun (a, b, c) => decide (a^2 + b^2 = c^2))

def triples : List (ℕ × ℕ × ℕ) :=
  List.range 10
    |> List.flatMap (fun a => List.range' a (10 - a +1)
    |> List.map (fun b => (a, b, 10 - a - b))) -- [(0, 0, 10), (0, 1, 9), ..., (9, 9, -8)]

#eval triples -- [(0, 0, 10), (0, 1, 9), (0, 2, 8), (0, 3, 7), (0, 4, 6), (0, 5, 5), (0, 6, 4), (0, 7, 3), (0, 8, 2), (0, 9, 1), (1, 1, 8), (1, 2, 7), (1, 3, 6), (1, 4, 5), (1, 5, 4), (1, 6, 3), (1, 7, 2), (1, 8, 1), (1, 9, 0), (2, 2, 6), (2,...
--    |> List.map (fun b => (a, b, 10 - a - b))) -- [(0, 0, 10), (0, 1, 9), ..., (9, 9, -8)]

def solution (opt : Option (ℕ × ℕ × ℕ)): ℕ :=
  let (a, b, c) := opt.getD (0, 0, 0)
  a * b * c

example : solution (findTriplet) = 31875000 := by native_decide


end ProjectEuler
