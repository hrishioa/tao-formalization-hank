# Complete This Lean Formalization

I have a partially formalized proof in `proof.lean` that needs **5 remaining proofs** filled in.

## Context

This is a formalization of a classical result in equational theories: **Equation 1689 implies the Singleton Law (Equation 2)**.

A **magma** is a type with a single binary operation `◇`. The proof shows that if a magma satisfies the equation:
```
x = (y ◇ x) ◇ ((x ◇ z) ◇ z)    [Equation 1689]
```
then it must be **trivial** (all elements equal), i.e., it satisfies:
```
x = y    [Equation 2]
```

This is a classical result from Kisielewicz (1997), and the human-readable proof strategy used here comes from the equational theories project.

## What's Done

✅ **Complete lemmas:**
- `lemma4_S_trivial` — Proves S(a, b) = a for all a, b, where S(z, x) = (x ◇ z) ◇ z
- `lemma5_intermediate` — Proves (z ◇ y) ◇ a = y for all z, y, a

These two lemmas use:
- Expansion of the S and f definitions
- Rewriting with the hypothesis `Equation1689 G`
- Symmetry and simplification tactics

## What's Left

### 1. **lemma1_S_equals_f_comp** (line 28)
```lean
lemma lemma1_S_equals_f_comp (h : Equation1689 G) (a b c : G) : S b a = a ◇ f b c
```

**Goal:** Prove that `S b a = a ◇ f b c` where:
- `S z x = (x ◇ z) ◇ z`
- `f x y = x ◇ S y x = x ◇ ((x ◇ y) ◇ y)`

**Informal proof sketch:**
- Apply h (equation1689) with x = S(b, a), y = arbitrary, z = S(c, b)
- Get: S(b, a) = (y ◇ S(b, a)) ◇ S(z, S(b, a))
- Use the fact that S(b, a) ◇ z simplifies to b by applying h with appropriate values
- Simplify RHS to a ◇ (b ◇ z) = a ◇ f(b, c)

**Tactics to try:**
- `have eq := h (S b a) _ (S c b)` to apply equation1689
- `simp [S, f]` to unfold definitions
- `rw [←h]` to rewrite using equation1689 in reverse

---

### 2. **lemma2_f_witnesses_S** (line 32)
```lean
lemma lemma2_f_witnesses_S (h : Equation1689 G) (a : G) : ∃ (b c d : G), f b c = S d a
```

**Goal:** Prove existence of witnesses b, c, d such that f(b, c) = S(d, a).

**Informal proof sketch:**
- Set b = S(x, a) for some arbitrary x
- Use lemma1: S(b, a) = a ◇ S(c, b)
- Therefore: f(b, c) = b ◇ S(c, b) = S(b, a) = S(f(c, b), a)
- Witness d = f(c, b)

**Tactics to try:**
- `use S x a, c, f c (S x a)` (or similar witness choice)
- `rw [lemma1_S_equals_f_comp]` to apply lemma1
- `unfold f` and `unfold S` to expand definitions and simplify

---

### 3. **lemma3_self_S** (line 36)
```lean
lemma lemma3_self_S (h : Equation1689 G) (a : G) : ∃ (e : G), S e a = a
```

**Goal:** For each a, find e such that S(e, a) = a.

**Informal proof sketch:**
- Left-multiply equation1689 by a³ = (a ◇ a) ◇ a with x = a, y = arbitrary, z = arbitrary
- Get: a = (a³ ◇ (arbitrary)) ◇ S(z, a)
- Use lemmas 1 and 2 to rewrite the RHS in terms of f
- Show a = S(f(a, d), a) for some d
- Therefore e = f(a, d)

**Tactics to try:**
- Define `a_cubed := (a ◇ a) ◇ a` for clarity
- `have eq := h a _ _` to get instances of equation1689
- `obtain ⟨b, c, d, hbc⟩ := lemma2_f_witnesses_S h a` to get witnesses from lemma2
- Carefully rewrite LHS and RHS using h, lemma1, and equation algebra
- Use `exact` with the constructed witness

---

### 4. **lemma6_final_triviality** (line 59)
```lean
lemma lemma6_final_triviality (h : Equation1689 G) (a b c d : G) : a = b
```

**Goal:** Prove that any two elements a and b are equal (triviality).

**Informal proof sketch:**
- From lemma5: (z ◇ y) ◇ a = y for all z, y, a
- Substitute z := d, y := a, a := c to get: (d ◇ a) ◇ c = a
- Substitute z := arbitrary, y := arbitrary to show a = b for any choice

**Tactics to try:**
- `have h5 := lemma5_intermediate h d a c` to instantiate lemma5
- `have h5_b := lemma5_intermediate h _ _ _` with appropriate substitutions
- Use transitivity of equality to chain instances together

---

### 5. **main** (line 63)
```lean
theorem main (h : Equation1689 G) : Equation2 G
```

**Goal:** Prove that `Equation1689 G` implies `Equation2 G`, i.e., if equation1689 holds then all elements are equal.

**Informal proof sketch:**
- Assume Equation1689 G
- Intros x y
- Apply lemma6_final_triviality with suitable arguments to show x = y

**Tactics to try:**
- `intro x y`
- `exact lemma6_final_triviality h x y _ _` (or similar with appropriate witness elements)

---

## How to Work

1. **Copy `proof.lean` into a Lean 4 project with Mathlib** (e.g., use the Lake template: `lake new myproj math`)
2. **Replace the main file** with `proof.lean`
3. **Run `lake build`** to see the sorry warnings and check compilation
4. **Fill one lemma at a time** in order of dependency: lemma1, lemma2, lemma3, lemma6, main
5. **After each fix**, run `lake build` to verify compilation
6. **Use the informal proof as a guide**, but don't be afraid to find cleaner Lean proof paths

## Hints

### General
- The key insight is that S and f are custom operations defined as abbreviations. Use `unfold S` and `unfold f` (or `simp [S, f]`) to expand them.
- The hypothesis `h : Equation1689 G` is what enables all steps. Use `have := h ...` to instantiate it with different variables.
- Equality chains are common; consider using `calc` for clarity.
- The completed lemmas (4 and 5) show the proof style: expand definitions, rewrite, simplify.

### Lemma-Specific Tips

**For lemma1:**
- The proof hinges on applying h with specific substitutions and then simplifying.
- Try starting: `have eq := h (S b a) (S c b) (S c b)` and see what you get.
- Then carefully expand S and f to match both sides.

**For lemma2:**
- Witness construction often requires choosing the right tuple of elements.
- The informal proof suggests `b = S(x, a)` is a good choice. Try `use S x a, c, ...`.
- After using lemma1, the proof should be mostly definitional rewriting.

**For lemma3:**
- This is the hardest lemma. Break it into steps:
  1. Define a³ and apply h with this in the RHS
  2. Use lemma2 to get witnesses for f
  3. Rewrite LHS using h and lemma1
  4. Show the equation gives S(f(a,d), a) = a

**For lemma6:**
- Multiple instantiations of lemma5 should suffice.
- Try: `h5_1 := lemma5_intermediate h d a c` and `h5_2 := lemma5_intermediate h d b c` or similar.

**For main:**
- Straightforward once lemma6 is done. Just introduce the variables and apply lemma6.

---

## References

- **Informal proof:** The original proof from the equational theories project (Kisielewicz 1997 via computer).
- **Lean reference:** [Lean 4 documentation](https://lean-lang.org/)
- **Mathlib:** The Lean Standard Library for mathematics.

Good luck! The structure is solid; it's mostly a matter of careful bookkeeping and tactical exploration.
