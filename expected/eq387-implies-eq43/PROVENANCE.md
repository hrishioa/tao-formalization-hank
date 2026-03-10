# Test Case: Equation 387 → Equation 43

**Difficulty:** Easy (3 lemmas, ~4 line proof)

## Source

- **Informal proof:** Extracted from `blueprint/src/chapter/implications.tex` in the [equational_theories](https://github.com/teorth/equational_theories) project. Originally from [MathOverflow](https://mathoverflow.net/a/450905/766).
- **Expected output:** Extracted from `equational_theories/Subgraph.lean` in the same project.
- **Equation definitions:** From `equational_theories/Equations/Basic.lean`.

## What We Did

1. Took the LaTeX proof from the blueprint and converted it to clean markdown
2. Named the intermediate steps as explicit lemmas (idem, comm, op_idem) to match the formalization structure
3. Extracted the existing compact formalization as `expected_output.lean`

## Why This Test Case

This is the simplest implication proof with lemma structure in the project. If the Hank can't formalize this, it can't formalize anything. Good for:
- Validating the basic pipeline works
- Testing with cheap models (Haiku)
- Quick iteration on prompt design
