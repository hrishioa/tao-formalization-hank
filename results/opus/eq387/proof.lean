import Mathlib.Tactic

-- Magma definition
class Magma (α : Type _) where
  op : α → α → α

infixl:65 " ◇ " => Magma.op

-- Equation definitions
abbrev Equation387 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = (y ◇ y) ◇ x
abbrev Equation43 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = y ◇ x

-- Proof namespace to avoid name collisions
namespace EqProof

variable {G : Type _} [Magma G]

-- (*): (x ◇ x) ◇ y = y ◇ x
-- Proof: Eq 387 with x↔y gives y ◇ x = (x ◇ x) ◇ y
lemma star (h : Equation387 G) (x y : G) : (x ◇ x) ◇ y = y ◇ x := by
  exact (h y x).symm

-- Squares are idempotent: (x ◇ x) ◇ (x ◇ x) = x ◇ x
lemma idem_sq (h : Equation387 G) (x : G) : (x ◇ x) ◇ (x ◇ x) = x ◇ x := by
  rw [star h x (x ◇ x)]
  exact (h x x).symm

-- Squares commute with everything: (x ◇ x) ◇ y = y ◇ (x ◇ x)
lemma sq_comm (h : Equation387 G) (x y : G) : (x ◇ x) ◇ y = y ◇ (x ◇ x) := by
  have := star h (x ◇ x) y
  rw [idem_sq h x] at this
  exact this

-- x ◇ y = (x ◇ x) ◇ (y ◇ y)
lemma op_sq (h : Equation387 G) (x y : G) : (x ◇ x) ◇ (y ◇ y) = x ◇ y := by
  calc (x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ x := star h x (y ◇ y)
    _ = x ◇ y := star h y x

-- Main theorem: Equation 387 implies Equation 43 (commutativity)
theorem Equation387_implies_Equation43
    (G : Type _) [Magma G] (h : Equation387 G) : Equation43 G := by
  intro x y
  calc x ◇ y = (x ◇ x) ◇ (y ◇ y) := (op_sq h x y).symm
    _ = (y ◇ y) ◇ (x ◇ x) := sq_comm h x (y ◇ y)
    _ = y ◇ x := op_sq h y x

end EqProof
