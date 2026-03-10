# Formalization Plan

## Equations
- Source equation: **Equation 1571**: `x = (y ◇ z) ◇ (y ◇ (x ◇ z))` for all x, y, z
- Target equation: **Equation 43** (Commutativity): `x ◇ y = y ◇ x` for all x, y

## Intermediate Equations
- **Equation 2662**: `x = ((x ◇ y) ◇ (x ◇ y)) ◇ x` for all x, y
- **Equation 40**: `x ◇ x = y ◇ y` for all x, y (constant squares)
- **Equation 16**: `x = y ◇ (y ◇ x)` for all x, y
- **Equation 14**: `x = y ◇ (x ◇ y)` for all x, y

## Notation
- `e` will denote the constant `x ◇ x` (which is the same for all x, by Equation 40)

## Proof Structure
- **Complex proof** (5 steps, 6+ lemmas, intermediate equations) → **skeleton then fill**

## Lemmas (in dependency order)

1. **eq2662**: `x = ((x ◇ y) ◇ (x ◇ y)) ◇ x` — depends on: eq1571 only
   - Substitution: set y → (x ◇ y), z → (x ◇ y) in 1571, plus z → y gives intermediate

2. **eq40** (constant squares): `x ◇ x = y ◇ y` — depends on: eq1571, eq2662
   - Show `(x ◇ y) ◇ (x ◇ y) = (y ◇ z) ◇ (y ◇ z)` via 1571 and 2662

3. **left_id**: `e ◇ x = x` — depends on: eq1571, eq40
   - From 1571 with x=y=z: x = e ◇ (x ◇ e)
   - From 1571 with y=z=e: x = e ◇ (e ◇ (x ◇ e)), so x = e ◇ x

4. **right_id**: `x ◇ e = x` — depends on: eq1571, eq40, left_id
   - From left_id and x = e ◇ (x ◇ e)

5. **eq16**: `x = y ◇ (y ◇ x)` — depends on: eq1571, right_id
   - From 1571 with z = e

6. **eq14**: `x = y ◇ (x ◇ y)` — depends on: eq1571, left_id
   - From 1571 with y = e

7. **involution**: `x = (x ◇ y) ◇ y` — depends on: eq14, eq16
   - Substitute z = x ◇ y in eq14, use eq16

8. **comm** (Equation 43): `x ◇ y = y ◇ x` — depends on: eq14, involution
   - y ◇ x = y ◇ ((x ◇ y) ◇ y) = x ◇ y by eq14

## Final Theorem
- `theorem eq1571_implies_eq43 (G : Type _) [Magma G] (h : Equation1571 G) : Equation43 G`
