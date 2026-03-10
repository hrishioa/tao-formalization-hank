# Formalization Complete

The informal proof has been fully formalized in Lean 4.

## Output
- `proof.lean` — The complete formalization. Compiles cleanly with `lake build` (zero sorries).

## Summary

This formalization proves that **Equation 3744 implies both Equation 3722 and Equation 381** in the theory of magmas.

**Equation 3744**: `x ◇ y = (x ◇ z) ◇ (w ◇ y)` for all x, y, z, w
**Equation 381**: `x ◇ y = (x ◇ z) ◇ y` for all x, y, z  
**Equation 3722**: `x ◇ y = (x ◇ y) ◇ (x ◇ y)` (idempotent products)

The proof uses four lemmas and two main theorems:

1. **`eq3744_instance_w_equals_y`** — Instantiates Eq3744 with `w = y`
2. **`eq3744_instance_y_equals_z_w_equals_x`** — Instantiates Eq3744 with `y = z` and `w = x`, yielding the idempotent form
3. **`eq3722_from_eq3744`** — Directly derives Equation 3722 from specialization (2)
4. **`eq381_from_eq3744`** — Derives Equation 381 by chaining the instantiations: eq1 → eq5 → eq1.trans eq5.symm

The proof follows the informal mathematical structure closely, using rewriting and equality chaining (`calc`-style composition via `.trans`).

## Compilation

```
lake build
Build completed successfully (3104 jobs).
```

No errors, no sorries, only a minor whitespace linter warning (harmless).
