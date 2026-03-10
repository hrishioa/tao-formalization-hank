# Formalization Plan

## Equations
- Source equation: Equation 387 — `∀ x y : G, x ◇ y = (y ◇ y) ◇ x`
- Target equation: Equation 43 — `∀ x y : G, x ◇ y = y ◇ x`

## Notation
- `x ◇ y` for the magma operation, via `infix:65 " ◇ " => Magma.op`
- No extra custom abbreviations are needed at the definition stage; the derived law `(*)` can be introduced later as a local lemma.

## Proof Structure
- This proof is best done as a skeleton-then-fill argument.
- Reason: it has a derived law `(*)` plus three named intermediate lemmas (`idem`, `comm`, `op_idem`) before the final theorem.

## Lemmas (in dependency order)
1. `star`: derive `((x ◇ x) ◇ y = y ◇ x)` by applying Equation 387 with `x := y`, `y := x ◇ x` — depends on: Equation 387 only.
2. `idem`: prove `((x ◇ x) ◇ (x ◇ x) = x ◇ x)` — depends on: `star` and Equation 387.
3. `comm`: prove `((x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ (x ◇ x))` by replacing `x` with `x ◇ x` in `star` and simplifying with `idem` — depends on: `star`, `idem`.
4. `op_idem`: prove `((x ◇ x) ◇ (y ◇ y) = x ◇ y)` using two applications of `star` — depends on: `star`.

## Final Theorem
- `Equation387 G → Equation43 G`.
- Use `op_idem` on both `(x, y)` and `(y, x)` together with `comm` to conclude `x ◇ y = y ◇ x`.
