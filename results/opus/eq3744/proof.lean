-- Equation 3744 implies Equation 381
import Mathlib.Tactic

-- Magma: a type with a single binary operation
class Magma (α : Type _) where
  op : α → α → α

infixl:65 " ◇ " => Magma.op

-- Equation definitions
abbrev Equation3744 (G : Type _) [Magma G] :=
  ∀ x y z w : G, x ◇ y = (x ◇ z) ◇ (w ◇ y)

abbrev Equation381 (G : Type _) [Magma G] :=
  ∀ x y z : G, x ◇ y = (x ◇ z) ◇ y

abbrev Equation3722 (G : Type _) [Magma G] :=
  ∀ x y : G, x ◇ y = (x ◇ y) ◇ (x ◇ y)

namespace EqProof

variable {G : Type _} [Magma G]

-- Step 1: Specialize w := y in Eq3744 to get x ◇ y = (x ◇ z) ◇ (y ◇ y)
lemma step1 (h : Equation3744 G) (x y z : G) : x ◇ y = (x ◇ z) ◇ (y ◇ y) := by
  exact h x y z y

-- Step 2: Specialize y := z, w := x in Eq3744 to get idempotency of products
lemma eq3722 (h : Equation3744 G) (x y : G) : x ◇ y = (x ◇ y) ◇ (x ◇ y) := by
  exact h x y y x

-- Final theorem: Equation 3744 implies Equation 381
theorem Equation3744_implies_Equation381 (h : Equation3744 G) : Equation381 G := by
  intro x y z
  have h1 := step1 h x y z          -- x ◇ y = (x ◇ z) ◇ (y ◇ y)
  have h3 := step1 h (x ◇ z) y (x ◇ z)  -- (x ◇ z) ◇ y = ((x ◇ z) ◇ (x ◇ z)) ◇ (y ◇ y)
  have h2 := eq3722 h x z           -- x ◇ z = (x ◇ z) ◇ (x ◇ z)
  rw [← h2] at h3                   -- h3: (x ◇ z) ◇ y = (x ◇ z) ◇ (y ◇ y)
  rw [h1, ← h3]

end EqProof
