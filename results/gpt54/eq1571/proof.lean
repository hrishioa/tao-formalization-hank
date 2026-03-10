import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

abbrev Equation1571 (G : Type _) [Magma G] :=
  ∀ x y z : G, x = (y ◇ z) ◇ (y ◇ (x ◇ z))

abbrev Equation43 (G : Type _) [Magma G] :=
  ∀ x y : G, x ◇ y = y ◇ x

abbrev Equation40 (G : Type _) [Magma G] :=
  ∀ x y : G, x ◇ x = y ◇ y

abbrev Equation2662 (G : Type _) [Magma G] :=
  ∀ x y : G, x = ((x ◇ y) ◇ (x ◇ y)) ◇ x

abbrev Equation16 (G : Type _) [Magma G] :=
  ∀ x y : G, x = y ◇ (y ◇ x)

abbrev Equation14 (G : Type _) [Magma G] :=
  ∀ x y : G, x = y ◇ (x ◇ y)

namespace EqProof

variable {G : Type _} [Magma G]

lemma eq2662 (h1571 : Equation1571 G) : Equation2662 G := by
  intro x y
  have h1 : x = (x ◇ y) ◇ (x ◇ (x ◇ y)) := h1571 x x y
  calc
    x = ((x ◇ y) ◇ (x ◇ y)) ◇ ((x ◇ y) ◇ (x ◇ (x ◇ y))) := h1571 x (x ◇ y) (x ◇ y)
    _ = ((x ◇ y) ◇ (x ◇ y)) ◇ x := by rw [← h1]

lemma pair_square_eq (h1571 : Equation1571 G) (h2662 : Equation2662 G)
    (a b c : G) :
    ((b ◇ c) ◇ (b ◇ c)) = ((a ◇ b) ◇ (a ◇ b)) := by
  have hb : b = ((b ◇ c) ◇ (b ◇ c)) ◇ b := h2662 b c
  calc
    ((b ◇ c) ◇ (b ◇ c)) = (a ◇ b) ◇ (a ◇ (((b ◇ c) ◇ (b ◇ c)) ◇ b)) :=
      h1571 ((b ◇ c) ◇ (b ◇ c)) a b
    _ = (a ◇ b) ◇ (a ◇ b) := by rw [← hb]

lemma pair_square_left_id (h1571 : Equation1571 G) (h2662 : Equation2662 G)
    (a b x : G) :
    ((a ◇ b) ◇ (a ◇ b)) ◇ x = x := by
  have hx : x = ((x ◇ a) ◇ (x ◇ a)) ◇ x := h2662 x a
  calc
    ((a ◇ b) ◇ (a ◇ b)) ◇ x = ((x ◇ a) ◇ (x ◇ a)) ◇ x := by
      rw [pair_square_eq h1571 h2662 x a b]
    _ = x := by rw [← hx]

lemma eq14_direct (h1571 : Equation1571 G) (h2662 : Equation2662 G) : Equation14 G := by
  intro x y
  calc
    x = (((y ◇ y) ◇ (y ◇ y)) ◇ y) ◇ (((y ◇ y) ◇ (y ◇ y)) ◇ (x ◇ y)) := by
      simpa using h1571 x (((y ◇ y) ◇ (y ◇ y))) y
    _ = y ◇ (((y ◇ y) ◇ (y ◇ y)) ◇ (x ◇ y)) := by
      rw [pair_square_left_id h1571 h2662 y y y]
    _ = y ◇ (x ◇ y) := by
      rw [pair_square_left_id h1571 h2662 y y (x ◇ y)]

lemma pair_square_right_id (h1571 : Equation1571 G) (h2662 : Equation2662 G)
    (a b x : G) :
    x ◇ ((a ◇ b) ◇ (a ◇ b)) = x := by
  have h14 : x = ((a ◇ b) ◇ (a ◇ b)) ◇ (x ◇ ((a ◇ b) ◇ (a ◇ b))) :=
    eq14_direct h1571 h2662 x ((a ◇ b) ◇ (a ◇ b))
  calc
    x ◇ ((a ◇ b) ◇ (a ◇ b)) = ((a ◇ b) ◇ (a ◇ b)) ◇ (x ◇ ((a ◇ b) ◇ (a ◇ b))) := by
      rw [pair_square_left_id h1571 h2662 a b (x ◇ ((a ◇ b) ◇ (a ◇ b)))]
    _ = x := by rw [← h14]

lemma eq16_direct (h1571 : Equation1571 G) (h2662 : Equation2662 G) : Equation16 G := by
  intro x y
  calc
    x = (y ◇ (((y ◇ y) ◇ (y ◇ y)))) ◇ (y ◇ (x ◇ (((y ◇ y) ◇ (y ◇ y))))) := by
      simpa using h1571 x y (((y ◇ y) ◇ (y ◇ y)))
    _ = y ◇ (y ◇ (x ◇ (((y ◇ y) ◇ (y ◇ y))))) := by
      rw [pair_square_right_id h1571 h2662 y y y]
    _ = y ◇ (y ◇ x) := by
      rw [pair_square_right_id h1571 h2662 y y x]

lemma eq40 (h1571 : Equation1571 G) (h2662 : Equation2662 G) : Equation40 G := by
  intro x y
  have h16 := eq16_direct h1571 h2662
  have hx : ((y ◇ y) ◇ (y ◇ y)) = x ◇ x := by
    have hs : ((y ◇ y) ◇ (y ◇ y)) = x ◇ (x ◇ ((y ◇ y) ◇ (y ◇ y))) :=
      h16 ((y ◇ y) ◇ (y ◇ y)) x
    simpa [pair_square_right_id h1571 h2662 y y x] using hs
  have hy : ((y ◇ y) ◇ (y ◇ y)) = y ◇ y := by
    have hs : ((y ◇ y) ◇ (y ◇ y)) = y ◇ (y ◇ ((y ◇ y) ◇ (y ◇ y))) :=
      h16 ((y ◇ y) ◇ (y ◇ y)) y
    simpa [pair_square_right_id h1571 h2662 y y y] using hs
  exact hx.symm.trans hy

lemma identity_left_aux (h1571 : Equation1571 G) (_h40 : Equation40 G) (x y : G) :
    x = (y ◇ y) ◇ (x ◇ (y ◇ y)) := by
  exact eq14_direct h1571 (eq2662 h1571) x (y ◇ y)

lemma identity_left (h1571 : Equation1571 G) (h40 : Equation40 G) (x y : G) :
    (y ◇ y) ◇ x = x := by
  have hs : y ◇ y = ((y ◇ y) ◇ (y ◇ y)) := h40 y (y ◇ y)
  calc
    (y ◇ y) ◇ x = (((y ◇ y) ◇ (y ◇ y)) ◇ x) := by
      exact congrArg (fun t => t ◇ x) hs
    _ = x := pair_square_left_id h1571 (eq2662 h1571) y y x

lemma identity_right (h1571 : Equation1571 G) (h40 : Equation40 G) (x y : G) :
    x ◇ (y ◇ y) = x := by
  have hs : y ◇ y = ((y ◇ y) ◇ (y ◇ y)) := h40 y (y ◇ y)
  calc
    x ◇ (y ◇ y) = x ◇ (((y ◇ y) ◇ (y ◇ y))) := by
      exact congrArg (fun t => x ◇ t) hs
    _ = x := pair_square_right_id h1571 (eq2662 h1571) y y x

lemma eq16 (h1571 : Equation1571 G) (_h40 : Equation40 G) : Equation16 G := by
  exact eq16_direct h1571 (eq2662 h1571)

lemma eq14 (h1571 : Equation1571 G) (_h40 : Equation40 G) : Equation14 G := by
  exact eq14_direct h1571 (eq2662 h1571)

lemma comm_aux (h16 : Equation16 G) (h14 : Equation14 G) (x y : G) :
    x = (x ◇ y) ◇ y := by
  calc
    x = (x ◇ y) ◇ (x ◇ (x ◇ y)) := h14 x (x ◇ y)
    _ = (x ◇ y) ◇ y := by rw [← h16 y x]

theorem equation1571_implies_equation43 (h1571 : Equation1571 G) : Equation43 G := by
  have h2662 := eq2662 h1571
  have h40 := eq40 h1571 h2662
  have h16 := eq16 h1571 h40
  have h14 := eq14 h1571 h40
  intro x y
  calc
    x ◇ y = y ◇ ((x ◇ y) ◇ y) := h14 (x ◇ y) y
    _ = y ◇ x := by rw [← comm_aux h16 h14 x y]

end EqProof
