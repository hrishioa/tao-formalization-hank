# Formalization Plan

## Equations
- **Source equation (Equation 387):** `x ◇ y = (y ◇ y) ◇ x` for all x, y
- **Target equation (Equation 43):** `x ◇ y = y ◇ x` for all x, y (commutativity)

## Notation
- No custom notation needed beyond the Magma `◇` operator.

## Proof Structure
- **Single pass** — the proof has 4 short lemmas in a clean dependency chain, each 1–3 rewrites. No custom notation or complex structures.

## Lemmas (in dependency order)

1. **star** (auxiliary law `(*)`): `(x ◇ x) ◇ y = y ◇ x`
   - Proof: Direct from Eq 387 (just swap x↔y in the equation).
   - Depends on: Eq 387 only.

2. **idem** (squares are idempotent): `(x ◇ x) ◇ (x ◇ x) = x ◇ x`
   - Proof: By `star` with y := x ◇ x we get `(x ◇ x) ◇ (x ◇ x) = (x ◇ x) ◇ x`.
     By Eq 387 with y := x we get `x ◇ x = (x ◇ x) ◇ x`. Combine.
   - Depends on: star, Eq 387.

3. **sq_comm** (squares commute with everything): `(x ◇ x) ◇ y = y ◇ (x ◇ x)`
   - Proof: In `star`, replace x with x ◇ x:
     `((x ◇ x) ◇ (x ◇ x)) ◇ y = y ◇ (x ◇ x)`. Then use idem on LHS.
   - Depends on: star, idem.

4. **op_sq** (operation equals product of squares): `(x ◇ x) ◇ (y ◇ y) = x ◇ y`
   - Proof: By `star` (with y := y ◇ y): `(x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ x`.
     By `star` (original): `(y ◇ y) ◇ x = x ◇ y`. Chain them.
   - Depends on: star.

## Final Theorem
- **Equation387_implies_Equation43**: `∀ (G : Type _) [Magma G], Equation387 G → Equation43 G`
- Proof: `x ◇ y = (x ◇ x) ◇ (y ◇ y)` (by op_sq reversed)
         `= (y ◇ y) ◇ (x ◇ x)` (by sq_comm or comm of squares)
         `= y ◇ x` (by op_sq).
- Depends on: op_sq, sq_comm (or equivalently, op_sq + comm of squares).
