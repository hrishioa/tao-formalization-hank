# Test Case: Equation 1689 → Equation 2

**Difficulty:** Medium (3 lemmas + helper + final theorem, custom notation)

## Source

- **Informal proof:** Extracted from `blueprint/src/chapter/implications.tex` in the [equational_theories](https://github.com/teorth/equational_theories) project. Originally from Kisielewicz (1997).
- **Expected output (compact):** Extracted from `equational_theories/Subgraph.lean` lines 310-354.
- **Expected output (Tao):** Reconstructed from Terence Tao's YouTube video demonstration and the file `analysis/Analysis/Misc/equational.lean` in [teorth/analysis](https://github.com/teorth/analysis).
- **Equation definitions:** From `equational_theories/Equations/Basic.lean`.

## What We Did

1. Took the LaTeX proof from the blueprint and converted to clean markdown
2. Expanded the terse notation to be self-contained
3. Extracted TWO reference formalizations:
   - `expected_output_compact.lean` — the existing project version (~45 lines, uses pow3/pow5)
   - `expected_output_tao.lean` — Tao's version from the video (~100 lines, uses S/f notation, comments)

## Why This Test Case

This is THE benchmark case:

- It's the exact proof Terence Tao formalized in the video that inspired this project
- Two reference outputs to compare against (compact vs verbose)
- Has custom notation (S, f) that needs to be introduced — tests Step 0
- Three lemmas with dependencies — tests the full skeleton→fill pipeline
- The proof Tao showed takes ~30 min with Claude Code interactively; a Hank should do it autonomously
- The informal proof has genuine complexity (existential witnesses, calc chains, rewriting)
