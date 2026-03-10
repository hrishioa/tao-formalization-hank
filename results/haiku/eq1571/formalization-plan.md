# Formalization Plan: Equation 1571 Implies Commutativity (Equation 43)

## Equations

- **Source equation (Equation 1571)**: `x = (y ◇ z) ◇ (y ◇ (x ◇ z))`
- **Target equation (Equation 43)**: `x ◇ y = y ◇ x` (Commutativity)

### Intermediate equations (used in the proof)

- **Equation 2662**: `x = ((x ◇ y) ◇ (x ◇ y)) ◇ x`
- **Equation 40**: `x ◇ x = y ◇ y` (all squares are equal)
- **Equation 16**: `x = y ◇ (y ◇ x)`
- **Equation 14**: `x = z ◇ (x ◇ z)` (also written as `x = (x ◇ z) ◇ z` in some contexts)

## Notation

No custom notation beyond the magma operation `◇`.

## Proof Structure

**Complexity**: Medium (5-6 interdependent lemmas with variable substitutions)
**Approach**: Skeleton then fill
- Structure depends on deriving intermediate equations step by step
- Custom variable substitutions in Equation 1571 are key
- The proof requires careful tracking of which equation enables which step

## Lemmas (in dependency order)

1. **eq2662_from_eq1571** (Lemma 1.1)
   - Statement: If Equation 1571 holds, then Equation 2662 holds
   - Dependencies: none
   - Method: Substitute x ↦ x, y ↦ x ◇ y, z ↦ x ◇ y into Eq1571; derive `x = ((x ◇ y) ◇ (x ◇ y)) ◇ ((x ◇ y) ◇ (x ◇ (x ◇ y)))`, then use another substitution to get the simplified form

2. **exists_constant_square** (Lemma 2)
   - Statement: If Equation 2662 holds, then there exists a constant e such that `x ◇ x = e` for all x
   - Dependencies: eq2662_from_eq1571
   - Method: From Eq2662 with various y, all expressions (x ◇ y) ◇ (x ◇ y) are shown to be equal, proving all squares equal

3. **identity_element** (Lemma 3)
   - Statement: The constant e from Lemma 2 is a left and right identity
   - Dependencies: exists_constant_square
   - Method: Apply Eq1571 with specific variable values (x = y = z) to show e ◇ x = x and x ◇ e = x

4. **eq16_from_eq1571** (Lemma 4)
   - Statement: If Equation 1571 holds, then Equation 16 holds: `x = y ◇ (y ◇ x)`
   - Dependencies: none (direct from Eq1571)
   - Method: Substitute z ↦ e into Eq1571

5. **eq14_from_eq1571** (Lemma 5)
   - Statement: If Equation 1571 holds, then Equation 14 holds: `x = z ◇ (x ◇ z)`
   - Dependencies: none (direct from Eq1571)
   - Method: Substitute y ↦ e into Eq1571

6. **commutativity_from_eq14_eq16** (Lemma 6)
   - Statement: If Equations 14 and 16 hold, then commutativity (Equation 43) holds
   - Dependencies: eq14_from_eq1571, eq16_from_eq1571
   - Method: Use Eq14 with z ↦ x ◇ y and Eq16 to derive `x ◇ y = y ◇ x`

## Final Theorem

- **eq1571_implies_eq43**: If a magma satisfies Equation 1571, then it satisfies Equation 43 (commutativity)
- Dependencies: all lemmas above
- Structure: Chain the lemmas together
