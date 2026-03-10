# Step 3: Fill in the Proofs

## Your Workspace

- `lean-project/Formalization/Basic.lean` — Contains the skeleton with `sorry` placeholders. This is the file you will edit.
- `informal_proof.md` — The original informal proof. Use it as a guide for proof strategy.
- `workspace/formalization-plan.md` — The formalization plan for reference.
- `sentinel-notes/` — Observer agents are watching your work and writing notes here. Check `sentinel-notes/latest-warning.md` if you're stuck — it may have suggestions.

## Process

### 1. Read the current state

Read `lean-project/Formalization/Basic.lean`. Note which lemmas have `sorry` — these are what you need to fill.

Read `informal_proof.md` for the proof ideas. The informal proof tells you the mathematical strategy, but the exact Lean tactics may differ.

### 2. Fill proofs one at a time

Work through the lemmas in order (respecting dependencies). For each `sorry`:

1. Read the informal proof's reasoning for this step
2. Replace `sorry` with a proof attempt
3. Run `lake build` from `lean-project/`
4. If it compiles: move to the next `sorry`
5. If it fails: read the error, adjust, try again

**Common proof strategies for equational theory proofs:**
- `repeat rw [← h]` — when the equation needs to be applied backwards multiple times
- `rw [← foo, ← h, foo]` — rewrite using a lemma, apply the equation, unrewrite
- `calc` blocks for chains of equalities
- `have step := h a b c` then `rw [step]` — instantiate the main equation with specific values
- `exact (h x y z).symm` — use the equation applied to specific values
- `congr` — when terms are equal up to congruence
- `grind` — powerful automation, good for goals that follow from hypotheses
- `simp only [...]` — targeted simplification

### 3. If stuck on a proof

If a particular `sorry` resists after 3-4 attempts:
- Leave the `sorry` in place
- Add a comment above it explaining what you tried and what went wrong:

```lean
-- TODO: Tried `rw [← h]`, `simp`, `grind`. Error: "rewrite failed, mismatch ..."
-- The informal proof suggests using congruence but types don't align.
sorry
```

Move on to the next `sorry`. Don't spend all your time on one step.

### 4. Fill the final theorem

The final theorem usually combines the lemmas. Common patterns:
- `exact fun x y ↦ by rw [← lemma1 h, lemma2 h, lemma1 h]`
- `intro x y; have h1 := lemma1 h x; ...; exact h1.trans h2.symm`

### 5. Final compilation check

Run `lake build` one last time. Note the result:
- Clean build (no warnings) = complete formalization
- `sorry` warnings = partial formalization (the next step will handle this)
- Errors = something broke; fix it

## Output

After this step:
- `lean-project/Formalization/Basic.lean` should compile (possibly with `sorry` warnings)
- As many `sorry` placeholders as possible should be replaced with real proofs
