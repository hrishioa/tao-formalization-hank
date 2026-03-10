# Formalization Plan: Equation 387 implies Equation 43

## Equations

- **Source equation (Eq387)**: `x ◇ y = (y ◇ y) ◇ x`
- **Target equation (Eq43)**: `x ◇ y = y ◇ x` (commutativity)

## Notation

No custom notation beyond the standard Magma operation `◇` is needed.

## Proof Structure

This is a moderately complex proof with 5 intermediate lemmas. It will be formalized in skeleton-then-fill approach:
- Complex chain of reasoning (5+ lemmas)
- Dependencies between lemmas
- Multiple applications of the same hypothesis

## Lemmas (in dependency order)

1. **helper_eq** (`(x ◇ x) ◇ y = y ◇ x`): 
   - Derived directly from Equation 387 by setting the first argument to `x ◇ x`
   - Depends on: Eq387

2. **idem** (`(x ◇ x) ◇ (x ◇ x) = x ◇ x`):
   - Idempotence of `x ◇ x`
   - Depends on: Eq387, helper_eq
   - Key step: Specialize helper_eq with `y := x ◇ x`, apply Eq387 again

3. **comm_op_idem** (`(x ◇ x) ◇ y = y ◇ (x ◇ x)`):
   - Swapped form of helper_eq using idem
   - Depends on: helper_eq, idem
   - Key step: Replace x by x ◇ x in helper_eq, then use idem

4. **comm** (`(x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ (x ◇ x)`):
   - Self-squares commute
   - Depends on: comm_op_idem
   - Instantiation of comm_op_idem

5. **op_idem** (`(x ◇ x) ◇ (y ◇ y) = x ◇ y`):
   - Product of squares equals the product
   - Depends on: helper_eq, Eq387
   - Key step: Two applications of helper_eq in a chain

6. **eq43_of_eq387** (Main theorem):
   - `x ◇ y = y ◇ x` (Equation 43)
   - Depends on: comm, op_idem
   - Key step: Combine both lemmas to get commutativity

## Final Theorem

```
theorem eq43_of_eq387 : Eq43 G ↔ ∀ x y : G, x ◇ y = y ◇ x
```

Actually, the theorem should be:

```
theorem eq43_of_eq387 {G : Type _} [Magma G] (h : Eq387 G) : Eq43 G
```

This shows that Eq387 implies Eq43.
