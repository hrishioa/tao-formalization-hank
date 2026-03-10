# Formalization Plan

## Equations
- Source equation: `Equation1689` — `∀ x y z : G, x = (y ◇ x) ◇ ((x ◇ z) ◇ z)`
- Target equation: `Equation2` — `∀ x y : G, x = y`

## Notation
- `S z x : G := (x ◇ z) ◇ z`
- `f x y : G := x ◇ S y x = x ◇ ((x ◇ y) ◇ y)`

## Proof Structure
- This is a complex proof: it uses custom notation, three major lemmas, and a nontrivial final collapse to the singleton law.
- Plan: use a skeleton-then-fill approach in later steps.
- Major phases:
  1. Set up `S` and `f` and the source/target equations.
  2. Prove Lemma 1 (`S b a = a ◇ f b c`).
  3. Prove Lemma 2 (every `a` has some `S d a` in the image of `f`).
  4. Prove Lemma 3 (`∃ e, S e a = a`).
  5. Deduce `S a y = a` for all `a, y`.
  6. Use the main equation again to derive the singleton law.

## Lemmas (in dependency order)
1. `s_mul_s`: `S b a ◇ S c b = b` — depends on: `Equation1689`
2. `lemma1`: `S b a = a ◇ f b c` for all `a b c` — depends on: `s_mul_s`
3. `lemma2`: for every `a`, there exist `b c d` such that `f b c = S d a` — depends on: `lemma1`
4. `lemma3`: for every `a`, there exists `e` such that `S e a = a` — depends on: `lemma1`, `lemma2`
5. `S_is_first_projection`: `S a y = a` for all `a, y` — depends on: `lemma3`, `Equation1689`
6. `collapse_step`: `(z ◇ y) ◇ a = y` for all `a, y, z` — depends on: `S_is_first_projection`, `Equation1689`

## Final Theorem
- `Equation1689 G → Equation2 G`
