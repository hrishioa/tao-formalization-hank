# Test Inputs for the Lean Formalization Hank

These are test cases for a Hank that automates Terence Tao's process of formalizing informal mathematical proofs into Lean 4, specifically equational theory implication proofs.

## Test Cases

| Directory | Implication | Difficulty | Lemmas | Notes |
|-----------|------------|------------|--------|-------|
| `eq387-implies-eq43/` | Eq387 → Eq43 | Easy | 3 (idem, comm, op_idem) | Algebraic manipulation |
| `eq953-implies-eq2/` | Eq953 → Eq2 | Medium-Easy | 0 (chain reasoning) | Existential witness |
| `eq3744-implies-eq381/` | Eq3744 → Eq381 | Easy-Medium | 0 (specializations) | Putnam 1978, chained congruence |
| `eq1689-implies-eq2/` | Eq1689 → Eq2 | Medium | 3 + helper + final | Tao's benchmark proof |
| `eq1571-implies-eq43/` | Eq1571 → Eq43 | Hard | 5-step chain | Derives identity, commutativity |

## Structure

Each test case contains:
- `informal_proof.md` — The informal proof in clean markdown (primary Hank input)
- `expected_output.lean` — A known-good Lean formalization (for validation)
- `PROVENANCE.md` — Where we got it, what we did, why it's useful

## Source

All materials extracted from the [equational_theories](https://github.com/teorth/equational_theories) project:
- Informal proofs from `blueprint/src/chapter/implications.tex`
- Formalizations from `equational_theories/Subgraph.lean`
- Equation definitions from `equational_theories/Equations/Basic.lean`

## Context

The equational theories project studies implications between 4,694 equational laws of magmas. A magma is simply a type with a binary operation `◇`. An "equation" is a universally quantified identity like `x ◇ y = y ◇ x`. The project proves or disproves whether one equation implies another.

The proofs we're formalizing are "positive implications" — proving that if a magma satisfies equation A, it must also satisfy equation B. These typically involve algebraic manipulation: specializing variables, deriving intermediate lemmas, and chaining results together.

All proofs use:
- `Mathlib.Tactic` for proof automation
- The `Magma` class with `◇` notation
- Equation definitions as `abbrev EquationN (G : Type _) [Magma G] := ∀ x y ... : G, lhs = rhs`
