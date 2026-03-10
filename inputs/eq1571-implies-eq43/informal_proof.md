# Equation 1571 implies Equation 43 (Commutativity)

## Equation Definitions

A **magma** is a type with a binary operation `◇`.

- **Equation 1571**: `x = (y ◇ z) ◇ (y ◇ (x ◇ z))` for all x, y, z
- **Equation 43** (Commutativity): `x ◇ y = y ◇ x` for all x, y
- **Equation 40**: `x ◇ x = y ◇ y` for all x, y (constant squares)
- **Equation 2662**: `x = ((x ◇ y) ◇ (x ◇ y)) ◇ x` for all x, y
- **Equation 16**: `x = y ◇ (y ◇ x)` for all x, y
- **Equation 14**: `x = y ◇ (x ◇ y)` for all x, y

## Goal

Prove that any magma satisfying Equation 1571 also satisfies Equation 43.

## Informal Proof

(From Mendelsohn-Padmanabhan)

Suppose that a magma G satisfies Equation 1571:

  x = (y ◇ z) ◇ (y ◇ (x ◇ z))                    ... (*)

### Step 1: Derive Equation 2662

From (*) with specific substitutions:

  x = ((x ◇ y) ◇ (x ◇ y)) ◇ ((x ◇ y) ◇ (x ◇ (x ◇ y)))

and

  x = (x ◇ y) ◇ (x ◇ (x ◇ y))

Combining these: x = ((x ◇ y) ◇ (x ◇ y)) ◇ x, which is Equation 2662.

### Step 2: Derive constant squares (Equation 40)

From Equation 2662: y = ((y ◇ z) ◇ (y ◇ z)) ◇ y.

From (*): (y ◇ z) ◇ (y ◇ z) = (x ◇ y) ◇ (x ◇ ((y ◇ z) ◇ (y ◇ z) ◇ y))

This implies (x ◇ y) ◇ (x ◇ y) = (y ◇ z) ◇ (y ◇ z), so the product (x ◇ y) ◇ (x ◇ y) is independent of x and y, hence equals some constant e.

In particular x ◇ x = e for all x, giving Equation 40.

### Step 3: e is an identity element

Applying (*) with x = y = z: x = e ◇ (x ◇ e).

Taking y = z = e: x = e ◇ (e ◇ (x ◇ e)), hence x = e ◇ x.

Then also x = x ◇ e. So e is an identity element.

### Step 4: Derive Equations 16 and 14

From (*) with z = e: x = y ◇ (y ◇ x), which is Equation 16.

From (*) with y = e: x = z ◇ (x ◇ z), which is Equation 14.

### Step 5: Derive commutativity

Substitute z = x ◇ y into Equation 14 and use Equation 16:

  x = (x ◇ y) ◇ y

Hence y ◇ x = y ◇ ((x ◇ y) ◇ y) = x ◇ y (by Equation 14).

This is Equation 43. ∎
