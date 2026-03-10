# Equation 3744 implies Equation 381

## Equation Definitions

A **magma** is a type with a binary operation `◇`.

- **Equation 3744**: `x ◇ y = (x ◇ z) ◇ (w ◇ y)` for all x, y, z, w
- **Equation 381**: `x ◇ y = (x ◇ z) ◇ y` for all x, y, z
- **Equation 3722**: `x ◇ y = (x ◇ y) ◇ (x ◇ y)` for all x, y (idempotent products)

## Goal

Prove that any magma satisfying Equation 3744 also satisfies Equation 381 (and Equation 3722).

## Informal Proof

(Putnam 1978, Problem A4, part (b))

By hypothesis, one has

  x ◇ y = (x ◇ z) ◇ (w ◇ y)

for all x, y, z, w. Various specializations of this give:

  x ◇ y = (x ◇ z) ◇ (y ◇ y)           ... (1)   [w = y]
  x ◇ z = (x ◇ z) ◇ (x ◇ z)           ... (2)   [y = z, w = x, using Eq3744]
  (x ◇ z) ◇ y = ((x ◇ z) ◇ (x ◇ z)) ◇ (y ◇ y)   ... (3)

Equation (2) gives Equation 3722 directly.

From (1), (2), and (3):

  x ◇ y = (x ◇ z) ◇ y

which is Equation 381. ∎
