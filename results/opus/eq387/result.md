# Formalization Complete

The informal proof has been fully formalized in Lean 4.

## Output
- `proof.lean` — The complete formalization. Compiles cleanly with `lake build`.

## Summary
Proved that Equation 387 (`x ◇ y = (y ◇ y) ◇ x`) implies Equation 43 (commutativity `x ◇ y = y ◇ x`) for all magmas. The proof consists of 4 helper lemmas (`star`, `idem_sq`, `sq_comm`, `op_sq`) chained together in a clean dependency order, using `rw`, `calc`, and `exact` as the primary tactics. The key insight is that squares are idempotent and commute with everything, reducing commutativity to a product-of-squares identity.
