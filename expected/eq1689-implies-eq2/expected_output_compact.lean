-- Reference formalization from the equational_theories project (Subgraph.lean, lines 310-354)
-- This is the compact version already in the project.

import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

abbrev Equation1689 (G : Type _) [Magma G] := ∀ x y z : G, x = (y ◇ x) ◇ ((x ◇ z) ◇ z)
abbrev Equation2 (G : Type _) [Magma G] := ∀ x y : G, x = y

variable {G : Type _} [Magma G]

namespace Eq1689

abbrev pow3 (a : G) : G := (a ◇ a) ◇ a
abbrev pow5 (a : G) : G := ((pow3 a) ◇ a) ◇ a
abbrev f (a b : G) : G := (a ◇ b) ◇ b
abbrev g (a b : G) : G := a ◇ ((a ◇ b) ◇ b)

lemma lem_fixf_implies_eq2 (h: Equation1689 G)
    (hfixf: ∀ b : G, ∃ c : G, f b c = b) : Equation2 G := by
  have fproj (a b : G) : f a b = b := by
    obtain ⟨c, hfbc⟩ := hfixf b
    unfold f at hfbc
    exact (hfbc ▸ (h b a c)).symm
  have eq30 (a b c : G) : a = (b ◇ a) ◇ c := by rw [← fproj a c, ← h]
  have eq6 (a b : G) : a = b ◇ b := by rw [eq30 a, ← eq30 b a]
  intro a b ; rw [eq6 a b, ← eq6]

lemma lem_1 (h: Equation1689 G) :
    ∀ a b c : G, a ◇ (f (f a b) c) = f a b := by
  intro a b c
  nth_rewrite 1 [h a a]
  exact (h ..).symm

lemma lem_2 (h: Equation1689 G) :
    ∀ a b c : G, a ◇ (g b c) = f a b := by
  intro a b c
  nth_rewrite 1 [g, h b]
  exact lem_1 h ..

lemma lem_fixf (h: Equation1689 G) :
    ∀ a : G, ∃ b : G, f a b = a := by
  intro a
  have h1 : pow3 a = a ◇ pow5 a := (lem_1 h ..).symm
  have h2 : g (pow3 a) a = f a (pow5 a) := congrArg (· ◇ _) h1
  have h3 : g a (pow5 a) = f a (pow3 a) := by rw [← lem_2 h, h2]
  have h4 : a ◇ (g a (pow5 a)) = pow3 a := by rw [lem_2 h]
  use (g a (pow5 a))
  rw [f, h4, h3, ← h]

end Eq1689

theorem Equation1689_implies_Equation2 (h: Equation1689 G) : Equation2 G :=
  Eq1689.lem_fixf_implies_eq2 h (Eq1689.lem_fixf h)
