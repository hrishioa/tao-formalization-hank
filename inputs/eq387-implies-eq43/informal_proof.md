# Equation 387 implies Equation 43

## Equation Definitions

A **magma** is a type with a binary operation `◇`.

- **Equation 387**: `x ◇ y = (y ◇ y) ◇ x` for all x, y
- **Equation 43** (Commutativity): `x ◇ y = y ◇ x` for all x, y

## Goal

Prove that any magma satisfying Equation 387 also satisfies Equation 43.

## Informal Proof

(From [MathOverflow](https://mathoverflow.net/a/450905/766))

By Equation 387, one has the law

  (x ◇ x) ◇ y = y ◇ x.                ... (*)

Specializing to y = x ◇ x, we conclude

  (x ◇ x) ◇ (x ◇ x) = (x ◇ x) ◇ x

and hence by another application of Equation 387 we see that x ◇ x is idempotent:

  **Lemma (idem):** (x ◇ x) ◇ (x ◇ x) = x ◇ x.

Now, replacing x by x ◇ x in (*) and then using idem we see that

  (x ◇ x) ◇ y = y ◇ (x ◇ x)

so in particular x ◇ x commutes with y ◇ y:

  **Lemma (comm):** (x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ (x ◇ x).

Also, from two applications of (*) one has

  (x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ x = x ◇ y.

  **Lemma (op_idem):** (x ◇ x) ◇ (y ◇ y) = x ◇ y.

Thus comm simplifies to x ◇ y = y ◇ x, which is Equation 43. ∎
