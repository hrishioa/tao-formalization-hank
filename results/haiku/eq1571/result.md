# Formalization Partially Complete

**3 proof obligations remain as `sorry` placeholders.**

## Output
- `proof.lean` — The partial formalization. Compiles cleanly with `lake build` (only `sorry` warnings).

## Summary

The formalization proves that **Equation 1571 implies Equation 43** (commutativity) for magmas, following the Mendelsohn-Padmanabhan approach. The proof is structured in 6 key lemmas:

1. ✅ **eq2662_from_eq1571**: Derives the intermediate equation `x = ((x ◇ y) ◇ (x ◇ y)) ◇ x` (Equation 2662) from Equation 1571 via congruence and equality chaining.

2. ❌ **exists_constant_square**: Shows that all squares `x ◇ x` equal a constant element. *Partially blocked: the proof requires analyzing how Equation 2662 constrains products of the form `(u ◇ v) ◇ (u ◇ v)`.*

3. ❌ **identity_element**: Proves the constant element is a left and right identity. *Blocked in two places:*
   - *Left identity*: Using Equation 1571 with specific substitutions to extract `e ◇ x = x`.
   - *Right identity*: Similar extraction for `x ◇ e = x`.

4. ✅ **eq16_from_eq1571** + helper: Derives `x = y ◇ (y ◇ x)` (Equation 16) from Equation 1571 and the identity element.

5. ✅ **eq14_from_eq1571** + helper: Derives `x = z ◇ (x ◇ z)` (Equation 14) from Equation 1571 and the identity element.

6. ✅ **commutativity_from_eq14_eq16**: Establishes commutativity from Equations 14 and 16 via congruence.

7. ✅ **eq1571_implies_eq43**: Main theorem combining all steps.

## Remaining Work

### Lemma 2: `exists_constant_square` (Line 45)

**Goal**: Show that from `∀ x y : G, x = ((x ◇ y) ◇ (x ◇ y)) ◇ x`, there exists `e : G` such that `∀ x : G, x ◇ x = e`.

**What was tried**: The structure was sketched but the equational manipulation to extract the constant wasn't completed.

**Mathematical idea**: 
- From the hypothesis `h : Equation2662 G`, instantiate with different `y` values to get two instances:
  - `h x y₁`: `x = ((x ◇ y₁) ◇ (x ◇ y₁)) ◇ x`
  - `h x y₂`: `x = ((x ◇ y₂) ◇ (x ◇ y₂)) ◇ x`
- By transitivity of equality, `((x ◇ y₁) ◇ (x ◇ y₁)) ◇ x = ((x ◇ y₂) ◇ (x ◇ y₂)) ◇ x`.
- Apply right cancellation (if provable) or extract the equality of the square terms by congruence.
- Define `e := x ◇ x` for any `x`, and verify it's constant.

**Suggested Lean approach**: Use `calc` chains to build up the equalities, or use `omega`/`grind` if the structure becomes equational.

### Lemma 3: `identity_element` – Left Identity Part (Line 61)

**Goal**: Show that if all `x ◇ x = e` and Equation 1571 holds, then `∀ x : G, e ◇ x = x`.

**What was tried**: The comment describes the intended derivation but the tactic proof is incomplete.

**Mathematical idea**:
- From Equation 1571 with `y := e, z := e`: `x = (e ◇ e) ◇ (e ◇ (x ◇ e))`.
- Since `e ◇ e = e` (because `e ◇ e` is a square), simplify to `x = e ◇ (e ◇ (x ◇ e))`.
- This is a fixed-point property: once we know `e` is a left identity for some `x`, we can propagate it.

**Suggested Lean approach**:
```lean
intro x
have eq_e := h e e e  -- e = (e ◇ e) ◇ (e ◇ (e ◇ e))
rw [he_const e] at eq_e  -- e = e ◇ (e ◇ e) using e ◇ e = e
rw [he_const e] at eq_e  -- e = e ◇ e, which holds
have eq := h x e e  -- x = (e ◇ e) ◇ (e ◇ (x ◇ e))
rw [he_const e] at eq  -- x = e ◇ (e ◇ (x ◇ e))
-- Now show e ◇ (x ◇ e) = x by another substitution
sorry
```

### Lemma 3: `identity_element` – Right Identity Part (Line 70)

**Goal**: Show that if all `x ◇ x = e` and Equation 1571 holds, then `∀ x : G, x ◇ e = x`.

**What was tried**: Similar structure; the tactic chain is incomplete.

**Mathematical idea**:
- From Equation 1571 with `y := x, z := e`: `x = (x ◇ e) ◇ (x ◇ (x ◇ e))`.
- We need to combine this with the left identity property (once proved) to extract `x ◇ e = x`.
- Alternatively, use Equation 1571 with other substitutions to build up the needed equalities.

**Suggested Lean approach**: Use a similar calc chain, possibly combined with the left identity once it's available. Consider introducing a helper lemma that uses both `h1571` and `he` iteratively.

## Suggested Next Steps

1. **Start with `exists_constant_square`**: This is the foundational lemma. Focus on:
   - Proving right cancellation (if needed) from the structure.
   - Using `calc` to compare two instances with different `y` values.
   - Extracting `∃ e` by choosing any element and showing constancy.

2. **Use `identity_element` as a stepping stone**: Once `exists_constant_square` is done, the identity proofs become more straightforward—you'll have explicit access to the constant `e` and its property `∀ x, x ◇ x = e`.

3. **Test incrementally**: After each `sorry` is filled, run `lake build` immediately. The error messages from the tactic state will guide the next steps.

4. **Consider proof assistants**: If Lean tactics become unwieldy, try using **Lean 4's interactive mode** (e.g., in VS Code with Lean 4 plugin) to explore the goal state and refine the tactics step-by-step.

5. **Reference Mendelsohn-Padmanabhan**: The informal proof in `informal_proof.md` is a detailed guide. For each `sorry`, map the informal step to the formal goal and apply tactics that correspond to the logical structure.
