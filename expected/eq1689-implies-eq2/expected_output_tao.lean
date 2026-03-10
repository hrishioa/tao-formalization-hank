-- Reference formalization by Terence Tao (from his YouTube video demonstration)
-- This is the detailed version that closely follows the informal proof structure.
-- It was produced using Claude Code with a step-by-step recipe.

import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

abbrev Equation1689 (M: Type _) [Magma M] := ∀ x y z : M, x = (y ◇ x) ◇ ((x ◇ z) ◇ z)
abbrev Equation2 (M: Type _) [Magma M] := ∀ x y : M, x = y

variable {M : Type _} [Magma M]

-- Step 0: S and f notation
-- S z x = (x ◇ z) ◇ z  (written S_z(x) in the informal proof)
abbrev S (z x : M) : M := (x ◇ z) ◇ z

-- f x y = x ◇ S y x = x ◇ ((x ◇ y) ◇ y)  (written f(x,y) in the informal proof)
abbrev f (x y : M) : M := x ◇ S y x

-- Auxiliary lemma used in Lemma 1 and Lemma 2:
-- S b a lies in the left ideal of a, i.e., S b a = a ◇ S z (S b a) for any z.
lemma S_left_ideal (h : Equation1689 M) (a b z : M) : S b a = a ◇ S z (S b a) := by
  have step := h ((a ◇ b) ◇ b) (a ◇ a) z
  grind

-- Lemma 1: For any a, b, c, one has S b a = a ◇ f b c.
lemma lemma1 (h : Equation1689 M) (a b c : M) : S b a = a ◇ f b c := by
  have h1 : ∀ z : M, S b a = a ◇ S z (S b a) := S_left_ideal h a b
  have h2 : S b a ◇ S c b = b := (h b (a ◇ b) c).symm
  have h3 : S (S c b) (S b a) = f b c := by grind
  calc S b a = a ◇ S (S c b) (S b a) := h1 (S c b)
    _ = a ◇ f b c := by rw [h3]

-- Lemma 2: For all a there exist b, c, d such that f b c = S d a.
lemma lemma2 (h : Equation1689 M) (a : M) : ∃ b c d : M, f b c = S d a := by
  use S a a, a, S a (S a a)
  have hb : S a a = a ◇ S a (S a a) := S_left_ideal h a a a
  calc f (S a a) a
      = S a a ◇ S a (S a a)              := rfl
    _ = (a ◇ S a (S a a)) ◇ S a (S a a) := by congr
    _ = S (S a (S a a)) a                := rfl

-- Lemma 3: For all a there exists e such that S e a = a.
lemma lemma3 (h : Equation1689 M) (a : M) : ∃ e : M, S e a = a := by
  obtain ⟨b, c, d, hd⟩ := lemma2 h a
  use f a d
  have h_main : a = ((a ◇ a) ◇ a) ◇ S b a := by grind
  have h_step2 : a = ((a ◇ a) ◇ a) ◇ (a ◇ f b c) :=
    h_main.trans (by rw [lemma1 h a b c])
  have h_step3 : a ◇ f b c = f a d := by grind
  have h_step4 : (a ◇ a) ◇ a = a ◇ f a d := by
    simpa only [S] using lemma1 h a a d
  calc S (f a d) a
      = (a ◇ f a d) ◇ f a d          := rfl
    _ = ((a ◇ a) ◇ a) ◇ f a d       := by rw [← h_step4]
    _ = ((a ◇ a) ◇ a) ◇ (a ◇ f b c) := by rw [← h_step3]
    _ = ((a ◇ a) ◇ a) ◇ S b a       := by rw [← lemma1 h a b c]
    _ = a                            := h_main.symm

-- Final step
theorem singleton_law (h : Equation1689 M) : Equation2 M := by
  have hS : ∀ a b : M, S a b = a := by
    intro a b
    obtain ⟨e, he⟩ := lemma3 h a
    grind
  have hrel : ∀ a b c : M, (a ◇ b) ◇ c = b := by
    intro a b c
    have step := h b a c
    grind
  have hconst : ∀ a b c : M, a ◇ b = c := by
    intro a b c
    have h1 : (a ◇ a) ◇ c = a := hrel a a c
    have h2 : ((a ◇ a) ◇ c) ◇ b = c := hrel (a ◇ a) c b
    grind
  intro x y
  exact (hconst x x x).symm.trans (hconst x x y)
