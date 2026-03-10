-- Reference from equational_theories project (Subgraph.lean)

import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

abbrev Equation3744 (G : Type _) [Magma G] := ∀ x y z w : G, x ◇ y = (x ◇ z) ◇ (w ◇ y)
abbrev Equation381 (G : Type _) [Magma G] := ∀ x y z : G, x ◇ y = (x ◇ z) ◇ y
abbrev Equation3722 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = (x ◇ y) ◇ (x ◇ y)

theorem Equation3744_implies_Equation381 (G : Type*) [Magma G] (h : Equation3744 G) : Equation381 G :=
  fun x y z ↦
    (h x y z y).trans $
    (congrArg (· ◇ (y ◇ y)) (h x z z x)).trans
    (h (x ◇ z) y (x ◇ z) y).symm

theorem Equation3744_implies_Equation3722 (G : Type*) [Magma G] (h : Equation3744 G) : Equation3722 G :=
  fun _ _ ↦ h ..
