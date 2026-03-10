# Formalization Plan: Equation 3744 implies Equation 381

## Equations
- **Source equation (Equation 3744)**: `x ◇ y = (x ◇ z) ◇ (w ◇ y)` for all x, y, z, w
- **Target equation 1 (Equation 381)**: `x ◇ y = (x ◇ z) ◇ y` for all x, y, z
- **Target equation 2 (Equation 3722)**: `x ◇ y = (x ◇ y) ◇ (x ◇ y)` for all x, y (idempotent products)

## Notation
None needed beyond the standard magma operation `◇`.

## Proof Structure
Single-pass formalization with embedded lemmas. The proof is straightforward:
- Three key instantiations of the axiom Eq3744
- Direct application and chain reasoning
- No complex custom notation or external dependencies

## Lemmas (in dependency order)

1. **eq3744_instance_w_equals_y**: Instantiate Eq3744 with w = y
   - Statement: Given `Eq3744`, we have `x ◇ y = (x ◇ z) ◇ (y ◇ y)`
   - Depends on: Nothing (direct instantiation of Eq3744)

2. **eq3744_instance_y_equals_z_w_equals_x**: Instantiate Eq3744 with y = z and w = x
   - Statement: Given `Eq3744`, we have `x ◇ z = (x ◇ z) ◇ (x ◇ z)`
   - Depends on: Nothing (direct instantiation of Eq3744)

3. **eq3722_from_eq3744**: Prove Equation 3722 from Equation 3744
   - Statement: `Eq3744 → Eq3722`
   - Depends on: eq3744_instance_y_equals_z_w_equals_x

4. **eq381_from_eq3744**: Prove Equation 381 from Equation 3744
   - Statement: `Eq3744 → Eq381`
   - Depends on: eq3744_instance_w_equals_y and eq3744_instance_y_equals_z_w_equals_x

## Final Theorems
- **theorem_eq3744_implies_eq3722**: `Eq3744 → Eq3722`
- **theorem_eq3744_implies_eq381**: `Eq3744 → Eq381`
