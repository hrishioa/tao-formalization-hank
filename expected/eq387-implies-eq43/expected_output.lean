-- Reference formalization from the equational_theories project (Subgraph.lean)
-- This is what a correct output looks like.

import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

abbrev Equation387 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = (y ◇ y) ◇ x
abbrev Equation43 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = y ◇ x

theorem Equation387_implies_Equation43 (G: Type*) [Magma G] (h: Equation387 G) : Equation43 G := by
  have idem (x : G) : (x ◇ x) ◇ (x ◇ x) = (x ◇ x) := by repeat rw [← h]
  have comm (x y : G) : (x ◇ x) ◇ y = y ◇ (x ◇ x) := by rw [← idem, ← h, idem]
  have op_idem (x y : G) : (x ◇ x) ◇ (y ◇ y) = x ◇ y := by repeat rw [← h]
  exact fun _ _ ↦ by rw [← op_idem, comm, op_idem]
