# Test Case: Equation 3744 → Equation 381

**Difficulty:** Easy-Medium (no lemmas, but requires chaining 3 specializations)

## Source

- **Informal proof:** From `blueprint/src/chapter/implications.tex`, Putnam 1978 Problem A4.
- **Expected output:** From `equational_theories/Subgraph.lean`.

## Why This Test Case

Tests a different proof pattern — no lemmas, just chained specializations and congruence. The proof is elegant term-mode Lean (no `by` block). Good test of whether the Hank handles proofs where the skeleton/fill split is unnecessary.
