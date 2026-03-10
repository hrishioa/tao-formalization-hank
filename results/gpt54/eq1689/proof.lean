import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

namespace EqProof

abbrev Equation1689 (G : Type _) [Magma G] :=
  ∀ x y z : G, x = (y ◇ x) ◇ ((x ◇ z) ◇ z)

abbrev Equation2 (G : Type _) [Magma G] :=
  ∀ x y : G, x = y

abbrev S {G : Type _} [Magma G] (z x : G) : G :=
  (x ◇ z) ◇ z

abbrev f {G : Type _} [Magma G] (x y : G) : G :=
  x ◇ S y x

lemma s_mul_s {G : Type _} [Magma G] (h : Equation1689 G) (a b c : G) :
    S b a ◇ S c b = b := by
  simpa [S] using (h b (a ◇ b) c).symm

lemma lemma1 {G : Type _} [Magma G] (h : Equation1689 G) (a b c : G) :
    S b a = a ◇ f b c := by
  calc
    S b a = ((a ◇ a) ◇ S b a) ◇ S (S c b) (S b a) := by
      simpa [S] using h (S b a) (a ◇ a) (S c b)
    _ = a ◇ S (S c b) (S b a) := by
      rw [← h a a b]
    _ = a ◇ ((S b a ◇ S c b) ◇ S c b) := rfl
    _ = a ◇ (b ◇ S c b) := by
      rw [s_mul_s h a b c]
    _ = a ◇ f b c := rfl

lemma lemma2 {G : Type _} [Magma G] (h : Equation1689 G) (a : G) :
    ∃ b c d : G, f b c = S d a := by
  refine ⟨S a a, a, S a (S a a), ?_⟩
  have hb : S a a = a ◇ S a (S a a) := by
    calc
      S a a = ((a ◇ a) ◇ S a a) ◇ S a (S a a) := by
        simpa [S] using h (S a a) (a ◇ a) a
      _ = a ◇ S a (S a a) := by
        rw [← h a a a]
  calc
    f (S a a) a = S a a ◇ S a (S a a) := rfl
    _ = (a ◇ S a (S a a)) ◇ S a (S a a) := by
      nth_rewrite 1 [hb]
      rfl
    _ = S (S a (S a a)) a := rfl

lemma lemma3 {G : Type _} [Magma G] (h : Equation1689 G) (a : G) :
    ∃ e : G, S e a = a := by
  obtain ⟨b, c, d, hfc⟩ := lemma2 h a
  have h1 : a = S a a ◇ S b a := by
    simpa [S] using h a (a ◇ a) b
  have hfd : a ◇ f b c = f a d := by
    rw [hfc]
  have h2 : a = (a ◇ f a d) ◇ f a d := by
    calc
      a = S a a ◇ S b a := h1
      _ = S a a ◇ (a ◇ f b c) := by
        rw [lemma1 h a b c]
      _ = S a a ◇ f a d := by
        rw [hfd]
      _ = (a ◇ f a d) ◇ f a d := by
        rw [lemma1 h a a d]
  refine ⟨f a d, ?_⟩
  simpa [S] using h2.symm

lemma S_is_first_projection {G : Type _} [Magma G] (h : Equation1689 G) (a y : G) :
    S a y = a := by
  obtain ⟨e, he⟩ := lemma3 h a
  have h' : a = S a y := by
    calc
      a = (y ◇ a) ◇ S e a := by
        simpa [S] using h a y e
      _ = (y ◇ a) ◇ a := by
        rw [he]
      _ = S a y := rfl
  exact h'.symm

lemma collapse_step {G : Type _} [Magma G] (h : Equation1689 G) (a y z : G) :
    (z ◇ y) ◇ a = y := by
  simpa [S_is_first_projection h a y] using (h y z a).symm

theorem equation1689_implies_equation2 {G : Type _} [Magma G] (h : Equation1689 G) :
    Equation2 G := by
  intro x y
  have hconst : ∀ a b c d : G, a ◇ b = c := by
    intro a b c d
    have h1 : (d ◇ a) ◇ c = a := collapse_step h c a d
    have h2 : ((d ◇ a) ◇ c) ◇ b = c := collapse_step h b c (d ◇ a)
    rw [h1] at h2
    exact h2
  have hx : x ◇ y = x := hconst x y x y
  have hy : x ◇ y = y := hconst x y y x
  exact hx.symm.trans hy

end EqProof
