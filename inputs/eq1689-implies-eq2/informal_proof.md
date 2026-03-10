# Equation 1689 implies Equation 2

## Equation Definitions

A **magma** is a type with a binary operation `◇`.

- **Equation 1689**: `x = (y ◇ x) ◇ ((x ◇ z) ◇ z)` for all x, y, z
- **Equation 2** (Singleton law): `x = y` for all x, y

## Goal

Prove that any magma satisfying Equation 1689 must be trivial (all elements are equal).

## Notation

Define:
- S(z, x) = (x ◇ z) ◇ z  (called S_z(x) in the informal proof)
- f(x, y) = x ◇ S(y, x) = x ◇ ((x ◇ y) ◇ y)

The main equation (Equation 1689) can be written as: x = (y ◇ x) ◇ S(z, x).

## Informal Proof

This result was first obtained by Kisielewicz in 1997 via computer assistance. The following human-readable proof was found in the course of the equational theories project.

### Lemma 1

**Statement:** For any a, b, c, one has S(b, a) = a ◇ f(b, c).

**Proof:** For x = S(b, a) and y ∈ Ma (i.e., y such that y ◇ x = a), we have y ◇ x = a. Then apply the main equation to these values of x, y to get:

  S(b, a) = a ◇ S(z, S(b, a))

for any z. Then set z = S(c, b) and note that S(b, a) ◇ z = ((a ◇ b) ◇ b) ◇ ((b ◇ c) ◇ c) = b (by the main equation with x = b, y = a ◇ b, z = c). This simplifies the right-hand side:

  S(b, a) = a ◇ ((S(b,a) ◇ z) ◇ z) = a ◇ (b ◇ z) = a ◇ f(b, c). ∎

### Lemma 2

**Statement:** For all a there exist b, c, d such that f(b, c) = S(d, a).

**Proof:** By definition of f one has f(b, c) = b ◇ S(c, b). Taking b = S(x, a) for some x, and rewriting b = a ◇ S(c, b) using the first equation in the proof of Lemma 1, we find:

  f(b, c) = (a ◇ S(c, b)) ◇ S(c, b)

which has the desired form S(d, a) for d = S(c, b). (Thus, the statement actually holds for all a, c.) ∎

### Lemma 3

**Statement:** For all a there exists e such that S(e, a) = a.

**Proof:** Left-multiply the equation in Lemma 1 by a³ = (a ◇ a) ◇ a to get (the first equality below comes from the main equation):

  a = ((a ◇ a) ◇ a) ◇ S(b, a) = a³ ◇ (a ◇ f(b, c)).

Take b, c, d as in Lemma 2 to rewrite a ◇ f(b, c) = a ◇ S(d, a) = f(a, d). On the other hand, Lemma 1 with a = b and c replaced by d implies a³ = a ◇ f(a, d), so overall we get:

  a = (a ◇ f(a, d)) ◇ f(a, d)

which is S(f(a,d), a) = a, as desired for e = f(a, d). ∎

### Final Step

For any a, y, using e from Lemma 3, the main equation gives:

  a = (y ◇ a) ◇ S(e, a) = (y ◇ a) ◇ a = S(a, y).

So S(a, b) = a for all a, b.

Inserting this back into the main equation gives (z ◇ y) ◇ a = y for any a, y, z.

Thus a ◇ b = ((d ◇ a) ◇ c) ◇ b = c for any a, b, c, d, thus a = b ◇ c = d for any a, b, c, d. ∎
