# Equation 953 implies Equation 2

## Equation Definitions

A **magma** is a type with a binary operation `◇`.

- **Equation 953**: `x = y ◇ ((z ◇ x) ◇ (z ◇ z))` for all x, y, z
- **Equation 2** (Singleton law): `x = y` for all x, y

## Goal

Prove that any magma satisfying Equation 953 must be trivial (all elements are equal).

## Informal Proof

Pick an element 0 of G and define 1 = 0 ◇ 0 and 2 = 1 ◇ 1.

From Equation 953 with x = z = 0 we have

  0 = y ◇ 2

for all y. (Since (0 ◇ 0) ◇ (0 ◇ 0) = 1 ◇ 1 = 2.)

If we then apply Equation 953 with z = 1 we get

  x = y ◇ ((1 ◇ x) ◇ (1 ◇ 1))
    = y ◇ ((1 ◇ x) ◇ 2)

But we just showed that anything ◇ 2 = 0, so (1 ◇ x) ◇ 2 = 0, giving

  x = y ◇ 0

for all x, y. Since the right side doesn't depend on x, we conclude x = x' for any x, x' ∈ G, giving Equation 2. ∎
