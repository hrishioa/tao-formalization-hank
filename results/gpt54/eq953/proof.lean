import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

abbrev Equation2 (G : Type _) [Magma G] := ∀ x y : G, x = y

abbrev Equation953 (G : Type _) [Magma G] :=
  ∀ x y z : G, x = y ◇ ((z ◇ x) ◇ (z ◇ z))

namespace EqProof

variable {G : Type _} [Magma G]

lemma anything_op_two_eq_zero (h : Equation953 G) (zero : G) :
    let one : G := zero ◇ zero
    let two : G := one ◇ one
    ∀ y : G, zero = y ◇ two := by
  dsimp
  intro y
  exact h zero y zero

lemma everything_eq_y_op_zero (h : Equation953 G) (zero : G) :
    ∀ x y : G, x = y ◇ zero := by
  let one : G := zero ◇ zero
  let two : G := one ◇ one
  have htwo : ∀ t : G, zero = t ◇ two := by
    simpa [one, two] using anything_op_two_eq_zero h zero
  intro x y
  have hx : x = y ◇ ((one ◇ x) ◇ two) := by
    simpa [one, two] using h x y one
  have hz : zero = (one ◇ x) ◇ two := htwo (one ◇ x)
  calc
    x = y ◇ ((one ◇ x) ◇ two) := hx
    _ = y ◇ zero := by rw [← hz]

lemma collapse_to_singleton (zero : G) (hzero : ∀ x y : G, x = y ◇ zero) :
    Equation2 G := by
  intro x y
  have hx : x = zero ◇ zero := hzero x zero
  have hy : y = zero ◇ zero := hzero y zero
  exact hx.trans hy.symm

theorem equation953_implies_equation2 (h : Equation953 G) : Equation2 G := by
  intro x y
  exact collapse_to_singleton x (everything_eq_y_op_zero h x) x y

end EqProof
