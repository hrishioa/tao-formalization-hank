# Formalization Plan

## Equations
- Source equation: Equation 953 — `∀ x y z : G, x = y ◇ ((z ◇ x) ◇ (z ◇ z))`
- Target equation: Equation 2 — `∀ x y : G, x = y`

## Notation
- Magma operation: `infix:65 " ◇ " => Magma.op`
- No additional custom abbreviations are needed at the definition stage.

## Proof Structure
- Single pass should be sufficient.
- The proof is short and only needs two intermediate observations before the final collapse to the singleton law.

## Lemmas (in dependency order)
1. `anything_op_two_eq_zero`: after fixing an arbitrary element `0`, defining `1 := 0 ◇ 0` and `2 := 1 ◇ 1`, show `∀ y, 0 = y ◇ 2` by instantiating Equation 953 with `x = 0` and `z = 0` — depends on: nothing.
2. `everything_eq_y_op_zero`: using the previous fact, instantiate Equation 953 with `z = 1` and rewrite `((1 ◇ x) ◇ (1 ◇ 1))` as `((1 ◇ x) ◇ 2) = 0`, obtaining `x = y ◇ 0` for all `x, y` — depends on: lemma 1.
3. Final collapse: since `x = y₀ ◇ 0` for every `x` with a fixed `y₀`, the right-hand side is independent of `x`, so any two elements are equal — depends on: lemma 2.

## Final Theorem
- Any magma satisfying Equation 953 also satisfies Equation 2.
