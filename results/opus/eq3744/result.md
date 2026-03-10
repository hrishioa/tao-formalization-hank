# Formalization Complete

The informal proof has been fully formalized in Lean 4.

## Output
- `proof.lean` — The complete formalization. Compiles cleanly with `lake build`.

## Summary
Proved that Equation 3744 (`x ◇ y = (x ◇ z) ◇ (w ◇ y)`) implies Equation 381 (`x ◇ y = (x ◇ z) ◇ y`) for magmas, via an intermediate idempotency lemma (Equation 3722: `x ◇ y = (x ◇ y) ◇ (x ◇ y)`). The proof consists of 3 lemmas — two specializations of Equation 3744 (`step1` and `eq3722`) and the final implication theorem — all proved by direct rewriting with no automation beyond `rw`.
