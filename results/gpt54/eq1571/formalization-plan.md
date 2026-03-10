# Formalization Plan

## Equations
- Source equation: Equation 1571 — `∀ x y z, x = (y ◇ z) ◇ (y ◇ (x ◇ z))`
- Target equation: Equation 43 — `∀ x y, x ◇ y = y ◇ x`

## Notation
- `class Magma (α : Type _) where op : α → α → α`
- `infix:65 " ◇ " => Magma.op`
- No additional custom abbreviations from the informal proof are needed at setup time.

## Proof Structure
- This is a multi-step proof with several derived equations and an implicit constant-square element `e`.
- It should be handled with a skeleton-then-fill approach.

## Lemmas (in dependency order)
1. `eq2662`: derive Equation 2662 from Equation 1571 by two specific substitutions into Equation 1571 and then combining the resulting equalities — depends on: nothing
2. `eq40`: derive constant squares from Equation 2662 together with Equation 1571, showing `x ◇ x = y ◇ y` for all `x, y` — depends on: `eq2662`
3. `identity_left_aux`: using Equation 1571 and Equation 40, show `x = e ◇ (x ◇ e)` where `e` is any square value such as `x ◇ x` — depends on: `eq40`
4. `identity_left`: show the square constant `e` acts as a left identity, i.e. `e ◇ x = x` — depends on: `identity_left_aux`
5. `identity_right`: show the same `e` acts as a right identity, i.e. `x ◇ e = x` — depends on: `identity_left`
6. `eq16`: derive Equation 16, `x = y ◇ (y ◇ x)`, by setting `z = e` in Equation 1571 and simplifying using the identity laws — depends on: `identity_left`, `identity_right`
7. `eq14`: derive Equation 14, `x = y ◇ (x ◇ y)`, by setting `y = e` in Equation 1571 and simplifying using the identity laws — depends on: `identity_left`, `identity_right`
8. `comm_aux`: substitute `z = x ◇ y` into Equation 14 and simplify via Equation 16` to obtain `x = (x ◇ y) ◇ y` — depends on: `eq16`, `eq14`

## Final Theorem
- `Equation1571 G → Equation43 G`: any magma satisfying Equation 1571 is commutative — depends on: `eq16`, `eq14`, `comm_aux`
