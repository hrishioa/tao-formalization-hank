import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

abbrev Equation3744 (G : Type _) [Magma G] :=
  ∀ x y z w : G, x ◇ y = (x ◇ z) ◇ (w ◇ y)

abbrev Equation381 (G : Type _) [Magma G] :=
  ∀ x y z : G, x ◇ y = (x ◇ z) ◇ y

abbrev Equation3722 (G : Type _) [Magma G] :=
  ∀ x y : G, x ◇ y = (x ◇ y) ◇ (x ◇ y)

namespace EqProof

variable {G : Type _} [Magma G]

lemma eq3744_wy (h : Equation3744 G) (x y z : G) :
    x ◇ y = (x ◇ z) ◇ (y ◇ y) := by
  exact h x y z y

lemma eq3722_of_eq3744 (h : Equation3744 G) (x y : G) :
    x ◇ y = (x ◇ y) ◇ (x ◇ y) := by
  exact h x y y x

lemma eq3744_on_prod (h : Equation3744 G) (x y z : G) :
    (x ◇ z) ◇ y = ((x ◇ z) ◇ (x ◇ z)) ◇ (y ◇ y) := by
  exact h (x ◇ z) y (x ◇ z) y

lemma eq381_of_eq3744_pointwise (h : Equation3744 G) (x y z : G) :
    x ◇ y = (x ◇ z) ◇ y := by
  calc
    x ◇ y = (x ◇ z) ◇ (y ◇ y) := eq3744_wy h x y z
    _ = ((x ◇ z) ◇ (x ◇ z)) ◇ (y ◇ y) := by
      simpa using congrArg (fun t => t ◇ (y ◇ y)) (eq3722_of_eq3744 h x z)
    _ = (x ◇ z) ◇ y := (eq3744_on_prod h x y z).symm

theorem equation3722_of_equation3744 (h : Equation3744 G) : Equation3722 G := by
  intro x y
  exact eq3722_of_eq3744 h x y

theorem equation381_of_equation3744 (h : Equation3744 G) : Equation381 G := by
  intro x y z
  exact eq381_of_eq3744_pointwise h x y z

end EqProof
