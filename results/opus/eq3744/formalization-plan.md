# Formalization Plan

## Equations
- Source equation: **Equation 3744**: `∀ x y z w, x ◇ y = (x ◇ z) ◇ (w ◇ y)`
- Target equation: **Equation 381**: `∀ x y z, x ◇ y = (x ◇ z) ◇ y`
- Intermediate: **Equation 3722**: `∀ x y, x ◇ y = (x ◇ y) ◇ (x ◇ y)` (idempotency of products)

## Notation
- No custom notation needed beyond `◇` for `Magma.op`

## Proof Structure
- Simple proof (2 lemmas + final theorem, short chain reasoning) → **single pass**
- All steps are short specializations and rewrites

## Lemmas (in dependency order)
1. **step1** (from 3744, set w := y): `∀ x y z, x ◇ y = (x ◇ z) ◇ (y ◇ y)` — depends on: Eq3744 only
2. **eq3722** (from 3744, set y := z, w := x): `∀ x y, x ◇ y = (x ◇ y) ◇ (x ◇ y)` — depends on: Eq3744 only

## Final Theorem
- **Equation3744_implies_Equation381**: `Equation3744 G → Equation381 G`
- Proof sketch:
  - From step1: `x ◇ y = (x ◇ z) ◇ (y ◇ y)`
  - From step1 (with x := x ◇ z, z := x ◇ z): `(x ◇ z) ◇ y = ((x ◇ z) ◇ (x ◇ z)) ◇ (y ◇ y)`
  - From eq3722: `(x ◇ z) ◇ (x ◇ z) = x ◇ z`, so: `(x ◇ z) ◇ y = (x ◇ z) ◇ (y ◇ y)`
  - Combine: `x ◇ y = (x ◇ z) ◇ (y ◇ y) = (x ◇ z) ◇ y` ∎
