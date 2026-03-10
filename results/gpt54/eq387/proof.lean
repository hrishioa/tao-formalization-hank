import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

abbrev Equation387 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = (y ◇ y) ◇ x

abbrev Equation43 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = y ◇ x

namespace EqProof

variable {G : Type _} [Magma G]

lemma star (h : Equation387 G) (x y : G) : (x ◇ x) ◇ y = y ◇ x := by
  exact (h y x).symm

lemma idem (h : Equation387 G) (x : G) : (x ◇ x) ◇ (x ◇ x) = x ◇ x := by
  exact (star h x (x ◇ x)).trans ((h x x).symm)

lemma comm (h : Equation387 G) (x y : G) : (x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ (x ◇ x) := by
  simpa [idem h x] using (star h (x ◇ x) (y ◇ y))

lemma op_idem (h : Equation387 G) (x y : G) : (x ◇ x) ◇ (y ◇ y) = x ◇ y := by
  exact (star h x (y ◇ y)).trans ((h x y).symm)

theorem equation387_implies_equation43 (h : Equation387 G) : Equation43 G := by
  intro x y
  calc
    x ◇ y = (x ◇ x) ◇ (y ◇ y) := (op_idem h x y).symm
    _ = (y ◇ y) ◇ (x ◇ x) := comm h x y
    _ = y ◇ x := op_idem h y x

end EqProof
