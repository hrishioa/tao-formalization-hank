-- Formalization: Equation 953 implies Equation 2
import Mathlib.Tactic

-- Magma definition
class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

-- Equation definitions
abbrev Equation953 (G : Type _) [Magma G] :=
  ∀ x y z : G, x = y ◇ ((z ◇ x) ◇ (z ◇ z))

abbrev Equation2 (G : Type _) [Magma G] :=
  ∀ x y : G, x = y

-- Proof namespace to avoid name collisions
namespace EqProof

variable {G : Type _} [Magma G]

-- Lemma 1: Specializing Eq953 with x = z = e0 gives e0 = y ◇ e2
-- where e2 = (e0 ◇ e0) ◇ (e0 ◇ e0)
lemma op_e2 (h : Equation953 G) (e0 y : G) :
    e0 = y ◇ ((e0 ◇ e0) ◇ (e0 ◇ e0)) := by
  exact h e0 y e0

-- Lemma 2: Using op_e2 and Eq953 with z = e0 ◇ e0, we get x = y ◇ e0
lemma op_e0 (h : Equation953 G) (e0 x y : G) :
    x = y ◇ e0 := by
  have step1 := h x y (e0 ◇ e0)
  -- step1 : x = y ◇ (((e0 ◇ e0) ◇ x) ◇ ((e0 ◇ e0) ◇ (e0 ◇ e0)))
  have step2 := op_e2 h e0 ((e0 ◇ e0) ◇ x)
  -- step2 : e0 = ((e0 ◇ e0) ◇ x) ◇ ((e0 ◇ e0) ◇ (e0 ◇ e0))
  rw [← step2] at step1
  exact step1

-- Main theorem: Equation 953 implies Equation 2 (all elements are equal)
theorem Equation953_implies_Equation2 (h : Equation953 G) : Equation2 G := by
  intro x y
  exact (op_e0 h x x y).trans (op_e0 h x y y).symm

end EqProof
