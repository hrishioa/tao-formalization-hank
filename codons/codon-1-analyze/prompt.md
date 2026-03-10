# Step 1: Analyze the Informal Proof and Set Up Definitions

## Your Workspace

- `lean-project/` — A Lean 4 project with Mathlib already configured and cached. Run `lake build` from here.
- `lean-project/Formalization/Basic.lean` — The file you will write your formalization into.
- `informal_proof.md` — The informal proof to formalize. Read this first.

## Process

### 1. Read the informal proof

Read `informal_proof.md` carefully. Identify:
- The equation names and their definitions (e.g., "Equation 387: x ◇ y = (y ◇ y) ◇ x")
- Any custom notation introduced (e.g., S(z,x), f(x,y))
- The lemmas used in the proof (named or unnamed intermediate results)
- The overall structure: how many major steps? Are there dependencies between lemmas?

### 2. Write the formalization plan

Create `workspace/formalization-plan.md` with:

```markdown
# Formalization Plan

## Equations
- Source equation: [name and definition]
- Target equation: [name and definition]

## Notation
- [Any custom abbreviations needed, with their Lean definitions]

## Proof Structure
- [Whether this needs skeleton/fill split or can be done in one pass]
- [Simple proofs (≤2 lemmas, short chain reasoning) → single pass]
- [Complex proofs (3+ lemmas, custom notation, long chains) → skeleton then fill]

## Lemmas (in dependency order)
1. [lemma name]: [statement in words] — [depends on: nothing / lemma X]
2. ...

## Final Theorem
- [statement]
```

### 3. Write the initial Lean file

Write `lean-project/Formalization/Basic.lean` with:
- `import Mathlib.Tactic`
- The Magma class definition
- The equation `abbrev` definitions (copy exactly from informal proof)
- Any custom notation as `abbrev` definitions
- A namespace for the proof (e.g., `namespace EqProof`)
- Nothing else yet — no lemmas, no theorems

### 4. Verify compilation

Run `lake build` from `lean-project/`. The file should compile cleanly (no errors, no warnings).

If it doesn't compile, fix the definitions until it does.

## Output

After this step, the workspace should contain:
- `workspace/formalization-plan.md` — the plan
- `lean-project/Formalization/Basic.lean` — compiling file with definitions only
