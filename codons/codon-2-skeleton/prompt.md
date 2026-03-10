# Step 2: Create the Proof Skeleton

## Your Workspace

- `workspace/formalization-plan.md` — The plan from the previous step. Read this first.
- `lean-project/Formalization/Basic.lean` — Contains imports, Magma class, equation definitions, and a namespace. You will add to this file.
- `informal_proof.md` — The original informal proof for reference.

## Process

### 1. Read the plan and current file

Read `workspace/formalization-plan.md` to understand:
- How many lemmas to create
- Whether custom notation abbrevs are needed
- The dependency order

Read `lean-project/Formalization/Basic.lean` to see what's already defined.

### 2. Add notation abbreviations (if the plan says so)

If the plan identifies custom notation (like `S(z,x)` or `f(x,y)`), add them as `abbrev` definitions inside the namespace.

### 3. Write lemma statements with `sorry`

For each lemma in the plan, write the Lean statement with `sorry` as the proof:

```lean
lemma my_lemma (h : EquationX G) (x y : G) : [statement] := by
  sorry
```

Follow the plan's dependency order. Use clear names that won't collide with Mathlib.

### 4. Write the final theorem statement with `sorry`

```lean
theorem main_theorem (h : EquationX G) : EquationY G := by
  sorry
```

### 5. Verify the skeleton compiles

Run `lake build` from `lean-project/`. You should see `sorry` warnings but NO errors.

If there are errors, the types are wrong. Fix them:
- Check that variable types match (G vs M, Type* vs Type _)
- Check that equation definitions are used correctly
- Check that notation abbrevs have the right signatures

**Do NOT try to prove anything.** Every proof body should be exactly `sorry`. The goal is to get the types right.

### 6. If the plan says "single pass" (no skeleton needed)

Some proofs are simple enough that skeleton/fill is unnecessary. If the plan says so, you may write the complete proof directly. But still run `lake build` to verify.

## Output

After this step:
- `lean-project/Formalization/Basic.lean` compiles with `sorry` warnings only
- All lemma and theorem statements are present with correct types
