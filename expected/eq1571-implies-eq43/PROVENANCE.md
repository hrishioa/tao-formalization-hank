# Test Case: Equation 1571 → Equation 43

**Difficulty:** Hard (5-step chain deriving identity, commutativity)

## Source

- **Informal proof:** From `blueprint/src/chapter/implications.tex`, originally from Mendelsohn-Padmanabhan.
- **Expected output:** Partial reference from `equational_theories/Subgraph.lean` (proves each implication separately).

## Why This Test Case

The hardest test case. Tests:
- Multi-step derivation (5 stages: 2662 → 40 → identity → 16,14 → 43)
- Existential reasoning (finding the identity element e)
- Complex intermediate equations
- Whether the Hank can handle a proof that needs 5+ lemmas
- How well the skeleton/fill pattern scales to longer proofs
