# Formalization Plan

## Equations
- Source equation: **Equation 953** — `x = y ◇ ((z ◇ x) ◇ (z ◇ z))` for all x, y, z
- Target equation: **Equation 2** (Singleton/Trivial law) — `x = y` for all x, y

## Notation
- `e0` : an arbitrary fixed element of G (obtained via `Nonempty` or `Inhabited`)
- `e1` : `e0 ◇ e0`
- `e2` : `e1 ◇ e1`

No custom notation operators needed; just local `let` or `have` bindings.

## Proof Structure
- **Single pass**: This is a short proof with 2 lemmas and a simple final step. No complex chains or custom notation needed.

## Lemmas (in dependency order)
1. **op_e2** : `∀ y, e0 = y ◇ e2` — From Eq953 with x = z = e0. Depends on: nothing (just Eq953).
2. **op_e0** : `∀ x y, x = y ◇ e0` — From Eq953 with z = e1, then using op_e2 to simplify `(e1 ◇ x) ◇ e2 = e0`. Depends on: op_e2.

## Final Theorem
- `Equation953_implies_Equation2`: `∀ (G : Type _) [Magma G], Equation953 G → Equation2 G`
- From op_e0: `x = y ◇ e0` and `x' = y ◇ e0`, so `x = x'`.
