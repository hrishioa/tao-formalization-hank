# Test Case: Equation 953 → Equation 2

**Difficulty:** Medium-Easy (no named lemmas, but chain of reasoning)

## Source

- **Informal proof:** Extracted from `blueprint/src/chapter/implications.tex` in the [equational_theories](https://github.com/teorth/equational_theories) project.
- **Expected output:** Extracted from `equational_theories/Subgraph.lean`.
- **Equation definitions:** From `equational_theories/Equations/Basic.lean`.

## What We Did

1. Took the LaTeX proof and converted to markdown
2. Made the reasoning chain explicit (pick 0, derive constants, conclude)
3. Extracted the existing formalization as `expected_output.lean`

## Why This Test Case

Interesting because:
- No explicit lemma structure — tests whether the Hank's decomposition codon can create one
- The proof has a "pick a witness and derive consequences" pattern
- Short enough for quick testing but non-trivial reasoning
- Different proof style from Eq387 (existential witness vs algebraic manipulation)
