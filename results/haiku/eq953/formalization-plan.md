# Formalization Plan: Equation 953 ⇒ Equation 2

## Equations
- **Source equation (Equation 953)**: `∀ x y z : G, x = y ◇ ((z ◇ x) ◇ (z ◇ z))`
- **Target equation (Equation 2, Singleton Law)**: `∀ x y : G, x = y`

## Proof Strategy
This is a **single-pass proof** with explicit lemmas. The proof flow is:
1. Assume a magma G satisfies Equation 953
2. Fix an arbitrary element 0 : G
3. Define derived elements: 1 := 0 ◇ 0, 2 := 1 ◇ 1
4. Use Equation 953 strategically to eliminate the operation
5. Conclude all elements are equal

## Lemmas (in dependency order)

1. **`eq_op_right_of_eq953`**: From Equation 953 with x = z = 0
   - Statement: `∀ y : G, 0 = y ◇ 2`
   - Given: Equation 953 instance, definitions of 1 and 2
   - Proof: Substitute x = 0, z = 0 into Eq 953, simplify (0 ◇ 0) = 1 and 1 ◇ 1 = 2

2. **`op_right_eq_zero`**: Consequence of lemma 1
   - Statement: `∀ x : G, (1 ◇ x) ◇ 2 = 0`
   - Given: Lemma 1
   - Proof: Apply lemma 1 to y := 1 ◇ x

3. **`eq_op_left`**: From Equation 953 with z = 1
   - Statement: `∀ x y : G, x = y ◇ 0`
   - Given: Equation 953, Lemma 2
   - Proof: Substitute z = 1 into Eq 953, simplify using 1 ◇ 1 = 2 and apply Lemma 2

4. **`eq_of_eq953`** (Main Theorem): Singleton Law
   - Statement: `∀ x y : G, x = y`
   - Given: Lemma 3 (for all x, y: x = y ◇ 0)
   - Proof: For any x, y: use Lemma 3 to get x = (y' ◇ 0) for appropriate y'; chain to conclude x = y

## Structure in Lean
```
import Mathlib.Tactic

-- Magma class definition
class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

-- Equation definitions
abbrev Equation953 (G : Type _) [Magma G] := ∀ x y z : G, x = y ◇ ((z ◇ x) ◇ (z ◇ z))
abbrev Equation2 (G : Type _) [Magma G] := ∀ x y : G, x = y

namespace EqProof

-- Lemmas and main theorem go here

end EqProof
```

## Notes
- All proofs will be in the `EqProof` namespace to avoid conflicts with Mathlib
- The key insight is that Equation 953 is so restrictive it forces all elements to be equal
- We use `have` to define 1 and 2 within the proof context
