-- Reference formalization from the equational_theories project (Subgraph.lean)
-- This is what a correct output looks like.

import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

abbrev Equation953 (G : Type _) [Magma G] := ∀ x y z : G, x = y ◇ ((z ◇ x) ◇ (z ◇ z))
abbrev Equation2 (G : Type _) [Magma G] := ∀ x y : G, x = y

theorem Equation953_implies_Equation2 (G : Type _) [Magma G] (h: Equation953 G) : Equation2 G := by
  intro x y
  have znx (z : G) : z ◇ ((x ◇ x) ◇ (x ◇ x)) = x := (h x z x).symm
  have hzzi := h x x (x ◇ x)
  have hyzi := h y x (x ◇ x)
  rw [znx] at hzzi hyzi
  exact hzzi.trans hyzi.symm
