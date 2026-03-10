# Formalization Plan

## Equations
- Source equation: Equation 3744 — `∀ x y z w : G, x ◇ y = (x ◇ z) ◇ (w ◇ y)`
- Target equation: Equation 381 — `∀ x y z : G, x ◇ y = (x ◇ z) ◇ y`
- Auxiliary equation: Equation 3722 — `∀ x y : G, x ◇ y = (x ◇ y) ◇ (x ◇ y)`

## Notation
- No extra custom notation appears in the informal proof beyond the magma operation `◇`.
- Lean definitions needed:
  - `class Magma (α : Type _) where op : α → α → α`
  - `infix:65 " ◇ " => Magma.op`

## Proof Structure
- This can likely be done in a single pass once the equations are set up.
- The proof uses only a few specializations of Equation 3744 and a short chain of rewrites.
- No skeleton/fill split should be necessary.

## Lemmas (in dependency order)
1. `eq3744_wy`: specialize Equation 3744 with `w = y` to get `x ◇ y = (x ◇ z) ◇ (y ◇ y)` — depends on: nothing
2. `eq3722_of_eq3744`: specialize Equation 3744 with `y = z` and `w = x` to get `x ◇ z = (x ◇ z) ◇ (x ◇ z)`; this is Equation 3722 — depends on: nothing
3. `eq3744_on_prod`: apply Equation 3744 with first argument `(x ◇ z)` and second argument `y` to get `((x ◇ z) ◇ y) = (((x ◇ z) ◇ (x ◇ z)) ◇ (y ◇ y))` after a suitable specialization — depends on: nothing
4. Final rewrite lemma: combine lemmas 1–3 using the idempotent-product identity to conclude `x ◇ y = (x ◇ z) ◇ y` — depends on: lemmas 1, 2, 3

## Final Theorem
- `Equation3744 G → Equation381 G`
- Likely also worth proving the auxiliary consequence `Equation3744 G → Equation3722 G`, since the informal proof derives it directly and then uses it.