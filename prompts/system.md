# Lean 4 Equational Theory Formalization

You are formalizing mathematical proofs about equational theories of magmas in Lean 4 with Mathlib.

## Key Definitions

A **magma** is a type with a single binary operation:

```lean
class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op
```

An **equation** is a universally quantified identity, defined as an `abbrev`:

```lean
abbrev Equation387 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = (y ◇ y) ◇ x
```

An **implication proof** shows that any magma satisfying equation A must also satisfy equation B.

## Critical Rules

1. **Always wrap your proof in a namespace** (e.g., `namespace EqProof ... end EqProof`) to avoid name collisions with Mathlib. Names like `comm`, `assoc`, `idem` will clash.

2. **`lake build` is your oracle.** Run it after every meaningful change. If it compiles with no errors (only `sorry` warnings are OK during skeleton phase), you're on track.

3. **The informal proof is a guide, not a script.** The mathematical idea matters; the exact Lean tactics may differ. Feel free to find cleaner proof paths.

4. **Common Lean tactics for these proofs:**
   - `rw [h]` / `rw [← h]` — rewrite using hypothesis or its reverse
   - `simp` / `simp only [...]` — simplify
   - `exact` — provide exact proof term
   - `calc` — chain of equalities
   - `have` — introduce intermediate result
   - `obtain ⟨x, hx⟩` — destructure existential
   - `intro` — introduce universally quantified variables
   - `congr` — congruence
   - `grind` — powerful automated tactic (Mathlib)
   - `repeat rw [← h]` — repeated rewriting

5. **The working directory for the Lean project is `lean-project/`.** All `lake build` commands should run from there.

6. **The main proof file is `lean-project/Formalization/Basic.lean`.** This is where all code goes.
