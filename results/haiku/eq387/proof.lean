import Mathlib.Tactic

-- ============================================================================
-- Magma Definition and Notation
-- ============================================================================

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

-- ============================================================================
-- Equation Definitions
-- ============================================================================

-- Equation 387: x ◇ y = (y ◇ y) ◇ x
abbrev Eq387 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = (y ◇ y) ◇ x

-- Equation 43: Commutativity x ◇ y = y ◇ x
abbrev Eq43 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = y ◇ x

-- ============================================================================
-- Proof Namespace
-- ============================================================================

namespace EqProof

-- ============================================================================
-- Helper Lemmas
-- ============================================================================

-- Lemma 1: From Eq387, we derive (x ◇ x) ◇ y = y ◇ x
-- Proof: Apply Eq387 with arguments swapped: h y x gives y ◇ x = (x ◇ x) ◇ y
lemma helper_eq {G : Type _} [Magma G] (h : Eq387 G) (x y : G) : 
  (x ◇ x) ◇ y = y ◇ x := by
  exact (h y x).symm

-- Lemma 2: x ◇ x is idempotent: (x ◇ x) ◇ (x ◇ x) = x ◇ x
-- Proof: From helper_eq with y := x ◇ x: (x ◇ x) ◇ (x ◇ x) = (x ◇ x) ◇ x
--        From Eq387 with x, x: x ◇ x = (x ◇ x) ◇ x, so (x ◇ x) ◇ x = x ◇ x by symmetry
lemma idem {G : Type _} [Magma G] (h : Eq387 G) (x : G) : 
  (x ◇ x) ◇ (x ◇ x) = x ◇ x := by
  have step1 := helper_eq h x (x ◇ x)
  have step2 : (x ◇ x) ◇ x = x ◇ x := (h x x).symm
  exact step1.trans step2

-- Lemma 3: x ◇ x commutes with any element: (x ◇ x) ◇ y = y ◇ (x ◇ x)
-- Proof: Apply helper_eq with x := x ◇ x, then use idem to simplify:
--        ((x ◇ x) ◇ (x ◇ x)) ◇ y = y ◇ (x ◇ x)  [by helper_eq]
--        (x ◇ x) ◇ y = y ◇ (x ◇ x)              [by idem]
lemma comm_op_idem {G : Type _} [Magma G] (h : Eq387 G) (x y : G) : 
  (x ◇ x) ◇ y = y ◇ (x ◇ x) := by
  have step := helper_eq h (x ◇ x) y
  rw [idem h x] at step
  exact step

-- Lemma 4: Self-squares commute: (x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ (x ◇ x)
-- Proof: Instantiate comm_op_idem with y := y ◇ y
lemma comm {G : Type _} [Magma G] (h : Eq387 G) (x y : G) : 
  (x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ (x ◇ x) := by
  exact comm_op_idem h x (y ◇ y)

-- Lemma 5: Product of squares equals the product: (x ◇ x) ◇ (y ◇ y) = x ◇ y
-- Proof: Two applications of helper_eq:
--        helper_eq h x (y ◇ y) gives: (x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ x
--        helper_eq h y x gives:       (y ◇ y) ◇ x = x ◇ y
lemma op_idem {G : Type _} [Magma G] (h : Eq387 G) (x y : G) : 
  (x ◇ x) ◇ (y ◇ y) = x ◇ y := by
  have step1 := helper_eq h x (y ◇ y)
  have step2 := helper_eq h y x
  exact step1.trans step2

-- ============================================================================
-- Main Theorem
-- ============================================================================

-- Theorem: Equation 387 implies Equation 43 (commutativity)
-- Proof: Chain the lemmas to show x ◇ y = y ◇ x
theorem eq43_of_eq387 {G : Type _} [Magma G] (h : Eq387 G) : Eq43 G := by
  intro x y
  have h1 := op_idem h x y     -- (x ◇ x) ◇ (y ◇ y) = x ◇ y
  have h2 := comm h x y        -- (x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ (x ◇ x)
  have h3 := op_idem h y x     -- (y ◇ y) ◇ (x ◇ x) = y ◇ x
  exact h1.symm.trans (h2.trans h3)

end EqProof
