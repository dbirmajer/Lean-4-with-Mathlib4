partial def takeWhile {α : Type} (s : Stream' α) (p : α -> Bool) (accum : List α := []): List α :=
  let x  := s.head
  if p x then takeWhile (s.tail) p (x :: accum) else accum

