# Formalization Plan

## Equations
- Source equation: **Equation 1689**: `∀ x y z : G, x = (y ◇ x) ◇ ((x ◇ z) ◇ z)`
- Target equation: **Equation 2** (Singleton/Trivial): `∀ x y : G, x = y`

## Notation
- `S (z x : G) : G := (x ◇ z) ◇ z` — used extensively throughout the proof
- `f (x y : G) : G := x ◇ S y x` — i.e., `x ◇ ((x ◇ y) ◇ y)`

The main equation can be restated as: `x = (y ◇ x) ◇ S z x`

## Proof Structure
- **Skeleton then fill**: This is a complex proof with 3 lemmas, custom notation, and intricate substitutions.
- Multiple lemmas with dependencies between them.
- Key challenge: Lemma 2 depends on an intermediate result from the *proof* of Lemma 1 (not just its statement).

## Lemmas (in dependency order)

1. **aux_eq** (auxiliary): `∀ a b z, S b a = a ◇ S z (S b a)`
   - Depends on: eq1689 only
   - Proof: From eq1689 with x=a, any y, z=b we get `a = (y ◇ a) ◇ S b a`.
     So `(y ◇ a) ◇ S(b,a) = a`, meaning y◇a is a "preimage" of a under `· ◇ S(b,a)`.
     Apply eq1689 with x=S(b,a), y=(y◇a): `S(b,a) = ((y◇a) ◇ S(b,a)) ◇ S(z, S(b,a)) = a ◇ S(z, S(b,a))`.

2. **lemma1**: `∀ a b c, S b a = a ◇ f b c`
   - Depends on: aux_eq, eq1689
   - Proof: Start from aux_eq with z = S(c, b).
     Show `S(b,a) ◇ S(c,b) = b` (using eq1689 with x=b, y=a◇b, z=c).
     Then `S(S(c,b), S(b,a)) = (S(b,a) ◇ S(c,b)) ◇ S(c,b) = b ◇ S(c,b) = f(b,c)`.

3. **lemma2**: `∀ a c x, f (S x a) c = S (S c (S x a)) a`
   - Depends on: aux_eq
   - Proof: Set b = S(x,a). From aux_eq: b = a ◇ S(c, b).
     Then `f(b,c) = b ◇ S(c,b) = (a ◇ S(c,b)) ◇ S(c,b) = S(S(c,b), a)`.
   - Corollary (existential form): `∀ a, ∃ b c d, f b c = S d a`

4. **lemma3**: `∀ a, ∃ e, S e a = a`
   - Depends on: lemma1, lemma2, eq1689
   - Proof:
     - Note `S(a,a) = (a ◇ a) ◇ a` (a³).
     - From eq1689 (x=a, y=a◇a, z=b): `a = S(a,a) ◇ S(b,a)`.
     - Apply lemma1: `a = S(a,a) ◇ (a ◇ f(b,c))`.
     - Choose b,c,d from lemma2 so `f(b,c) = S(d,a)`.
     - Then `a ◇ f(b,c) = a ◇ S(d,a) = f(a,d)`.
     - From lemma1 (a=a, b=a, c=d): `S(a,a) = a ◇ f(a,d)`.
     - So `a = (a ◇ f(a,d)) ◇ f(a,d) = S(f(a,d), a)`. Take e = f(a,d).

5. **S_const**: `∀ a b, S a b = a`
   - Depends on: lemma3, eq1689
   - Proof: Fix a. Get e from lemma3 with S(e,a) = a.
     Then eq1689: `a = (y ◇ a) ◇ S(e,a) = (y ◇ a) ◇ a = S(a, y)`.
     So `S(a, y) = a` for all y. Hence `S(a, b) = a` for all a, b.

6. **final theorem** (`Equation1689_implies_Equation2`): `∀ x y : G, x = y`
   - Depends on: S_const, eq1689
   - Proof: From eq1689 + S_const: `x = (y ◇ x) ◇ z` for all x, y, z.
     Then `a ◇ b = ((d ◇ a) ◇ c) ◇ b = c` for any a,b,c,d. So x = y.

## Final Theorem
```
theorem Equation1689_implies_Equation2 (G : Type _) [Magma G]
    (h : Equation1689 G) : Equation2 G
```
