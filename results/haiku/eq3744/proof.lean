import Mathlib.Tactic

-- Define a magma: a type with a single binary operation
class Magma (α : Type _) where
  op : α → α → α

-- Infix notation for the magma operation
infix:65 " ◇ " => Magma.op

namespace EqProof

-- Equation 3744: x ◇ y = (x ◇ z) ◇ (w ◇ y) for all x, y, z, w
abbrev Equation3744 (G : Type _) [Magma G] := ∀ x y z w : G, x ◇ y = (x ◇ z) ◇ (w ◇ y)

-- Equation 381: x ◇ y = (x ◇ z) ◇ y for all x, y, z
abbrev Equation381 (G : Type _) [Magma G] := ∀ x y z : G, x ◇ y = (x ◇ z) ◇ y

-- Equation 3722: x ◇ y = (x ◇ y) ◇ (x ◇ y) for all x, y (idempotent products)
abbrev Equation3722 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = (x ◇ y) ◇ (x ◇ y)

-- Lemma 1: Instantiate Eq3744 with w = y
lemma eq3744_instance_w_equals_y {G : Type _} [Magma G] (h : Equation3744 G) 
    (x y z : G) : x ◇ y = (x ◇ z) ◇ (y ◇ y) := by
  exact h x y z y

-- Lemma 2: Instantiate Eq3744 with y = z and w = x
lemma eq3744_instance_y_equals_z_w_equals_x {G : Type _} [Magma G] (h : Equation3744 G)
    (x z : G) : x ◇ z = (x ◇ z) ◇ (x ◇ z) := by
  exact h x z z x

-- Lemma 3: Prove Equation 3722 from Equation 3744
lemma eq3722_from_eq3744 {G : Type _} [Magma G] (h : Equation3744 G) : Equation3722 G := by
  intro x y
  exact eq3744_instance_y_equals_z_w_equals_x h x y

-- Lemma 4: Prove Equation 381 from Equation 3744
lemma eq381_from_eq3744 {G : Type _} [Magma G] (h : Equation3744 G) : Equation381 G := by
  intro x y z
  -- From Lemma 1: x ◇ y = (x ◇ z) ◇ (y ◇ y)
  have eq1 := eq3744_instance_w_equals_y h x y z
  -- Apply h to (x ◇ z), y, (x ◇ z), y: (x ◇ z) ◇ y = ((x ◇ z) ◇ (x ◇ z)) ◇ (y ◇ y)
  have eq2 := h (x ◇ z) y (x ◇ z) y
  -- From Lemma 2 with x := x ◇ z: (x ◇ z) ◇ (x ◇ z) = x ◇ z
  have eq3 := eq3744_instance_y_equals_z_w_equals_x h x z
  -- Rewrite using eq3: ((x ◇ z) ◇ (x ◇ z)) ◇ (y ◇ y) = (x ◇ z) ◇ (y ◇ y)
  have eq4 : ((x ◇ z) ◇ (x ◇ z)) ◇ (y ◇ y) = (x ◇ z) ◇ (y ◇ y) := by
    rw [← eq3]
  -- Chain: (x ◇ z) ◇ y = ((x ◇ z) ◇ (x ◇ z)) ◇ (y ◇ y) = (x ◇ z) ◇ (y ◇ y)
  have eq5 : (x ◇ z) ◇ y = (x ◇ z) ◇ (y ◇ y) := eq2.trans eq4
  -- Final chain: x ◇ y = (x ◇ z) ◇ (y ◇ y) = (x ◇ z) ◇ y
  exact eq1.trans eq5.symm

-- Theorem 1: Equation 3744 implies Equation 3722
theorem theorem_eq3744_implies_eq3722 {G : Type _} [Magma G] (h : Equation3744 G) : 
    Equation3722 G := 
  eq3722_from_eq3744 h

-- Theorem 2: Equation 3744 implies Equation 381
theorem theorem_eq3744_implies_eq381 {G : Type _} [Magma G] (h : Equation3744 G) : 
    Equation381 G := 
  eq381_from_eq3744 h

end EqProof
