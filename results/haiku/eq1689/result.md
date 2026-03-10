# Formalization Partially Complete

5 proof obligations remain as `sorry` placeholders.

## Output
- `proof.lean` — The partial formalization. Compiles successfully with `sorry` warnings.

## Compilation Status
✅ **Build successful** via `lake build` (warnings only for `sorry`)

## Summary
The formalization of "Equation 1689 implies Equation 2" (a magma triviality result from Kisielewicz 1997) is partially complete. The proof structure follows the informal proof closely:
- **Completed lemmas**: 
  - `lemma4_S_trivial` — proved that S(a, b) = a for all a, b
  - `lemma5_intermediate` — proved that (z ◇ y) ◇ a = y for all z, y, a
- **Remaining work**: 3 key lemmas + 2 high-level uses (6 lemmas total, 5 sorries due to lemma4 and lemma5 being complete)

## Remaining Work

### 1. `lemma1_S_equals_f_comp` (line 28)
**Type:** `∀ (a b c : G), S b a = a ◇ f b c`

**What it proves:** This is the first key lemma showing that S(b, a) equals a composed with the f operation.

**Status:** Skeleton exists, proof not filled.

**What was attempted:** The informal proof applies Equation 1689 and substitutes z = S(c, b), then simplifies using properties of S and f.

---

### 2. `lemma2_f_witnesses_S` (line 32)
**Type:** `∀ (a : G), ∃ (b c d : G), f b c = S d a`

**What it proves:** For any a, there exist witnesses b, c, d such that f(b, c) = S(d, a).

**Status:** Skeleton exists, proof not filled.

**What was attempted:** The informal proof constructs witnesses from lemma1 by rewriting f in terms of S.

---

### 3. `lemma3_self_S` (line 36)
**Type:** `∀ (a : G), ∃ (e : G), S e a = a`

**What it proves:** For each element a, there exists e such that S(e, a) = a.

**Status:** Skeleton exists, proof not filled.

**What was attempted:** The informal proof uses lemmas 1 and 2 to construct e and show the equality by left-multiplying by a³ = (a ◇ a) ◇ a and simplifying via equation1689.

---

### 4. `lemma6_final_triviality` (line 59)
**Type:** `∀ (a b c d : G), a = b`

**What it proves:** All elements of G are equal (final triviality step).

**Status:** Skeleton exists, proof not filled.

**What was attempted:** The informal proof uses lemma5 with different variable assignments: starting from (d ◇ a) ◇ c = a, then showing a = b ◇ c = d for arbitrary variables, thus proving any two elements are equal.

---

### 5. `main` theorem (line 63)
**Type:** `Equation1689 G → Equation2 G`

**What it proves:** The main result: any magma satisfying Equation 1689 must satisfy the singleton law (triviality).

**Status:** Skeleton exists, proof not filled.

**What was attempted:** Assume equation1689, apply lemmas sequentially to derive that all elements are equal.

---

## Suggested Next Steps

1. **Start with lemma3_self_S** — It's the key existential that unlocks the rest. The informal proof provides clear construction: use a³ = (a ◇ a) ◇ a, apply lemmas 1 and 2 to get the witness e = f(a, d), then verify S(f(a,d), a) = a by expanding definitions and rewriting with equation1689.

2. **Then lemma1_S_equals_f_comp** — Once lemma3 is done, go back and fill lemma1 using the informal proof's application of equation1689 and the substitution z = S(c, b). Use tactics like `have`, `rw`, and `unfold` to expand S and f definitions.

3. **Then lemma2_f_witnesses_S** — Use lemma1 to construct the witnesses. The witness e = S(c, b) can be obtained by setting b = S(x, a) and rewriting using lemma1.

4. **Then lemma6_final_triviality** — Use lemma5_intermediate to show all elements are equal by applying it with various variable substitutions.

5. **Finally main** — Combine all lemmas: assume equation1689, apply lemma6 to show ∀ x y, x = y.

## Technical Notes

- The namespace `EqProof` is used to avoid collisions with Mathlib (e.g., names like `comm`, `assoc`, `idem`).
- Custom abbreviations `S` and `f` are defined for readability.
- The proof depends heavily on expanding definitions of S and f and using the hypothesis `Equation1689 G` (the assumption that equation1689 holds).
- Consider using `simp [S, f]` to unfold definitions, and `calc` or `rw` for equality chains.
