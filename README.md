# Lean Proof Formalization Hank

A [Hankweave](https://github.com/SouthBridgeAI/hankweave-runtime) pipeline that automatically formalizes informal mathematical proofs into Lean 4, inspired by [Terence Tao's demonstration](https://www.youtube.com/watch?v=JHEO7cplfk8) of using Claude Code to formalize proofs in the [equational theories project](https://github.com/teorth/equational_theories).

## What This Does

Given an informal proof (in markdown) that one equational law implies another, this Hank produces a compiling Lean 4 formalization — automatically, without human intervention.

The process follows Tao's key insight: **skeleton first, fill later**. Instead of asking an AI to formalize a proof in one shot (which leads to 45 minutes of going in circles), the Hank breaks the task into structured steps with compilation checks between each.

Disclaimer: This hank is meant as a fun experiment, to compare models on math capabilities, and to explore agentic programming with lean. Not for production use, or anything that is less than 7/10 on fun.

## Background

Recently, Terence Tao posted a [YouTube video](https://www.youtube.com/watch?v=JHEO7cplfk8) showing himself using Claude Code to formalize a proof that Equation 1689 implies Equation 2 (the singleton law) from the [equational theories project](https://github.com/teorth/equational_theories). His process, refined over three attempts, was:

1. **Attempt 1:** Asked Claude to do everything at once. Ran 45 minutes, crashed, accomplished nothing.
2. **Attempt 2:** Broke it into steps (formalize definitions, skeleton with `sorry`, fill proofs). Worked in 25 minutes.
3. **Attempt 3 (the video):** Same step-by-step approach but with a written recipe. Worked in ~30 minutes.

The key discoveries:

- Breaking into **skeleton then fill** prevents the agent from overthinking
- Each lemma should be formalized independently (natural checkpoints)
- `lake build` is the oracle — run it after every change
- The informal proof is a **guide**, not a script — the Lean proof may take a cleaner path

This Hank freezes that process so it runs autonomously.

## How the Hank Works

```
Input: informal_proof.md
  │
  ▼
┌─────────────────────────────────────────────────┐
│ Codon 1: Analyze & Plan                         │
│ • Read informal proof                           │
│ • Identify equations, notation, lemma structure  │
│ • Write definitions in Lean, verify compilation  │
│ • Rig: copies Lean project template, fetches     │
│   Mathlib cache                                  │
└──────────────────┬──────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────┐
│ Codon 2: Skeleton                               │
│ • Write lemma statements with `sorry` proofs     │
│ • Write final theorem statement with `sorry`     │
│ • Run `lake build` — types must be correct       │
│ • Do NOT attempt to prove anything yet           │
└──────────────────┬──────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────┐
│ Codon 3: Fill Proofs               🔍 sentinels │
│ • Fill each `sorry` with a real proof            │
│ • Run `lake build` after each fill               │
│ • Narrator sentinel tracks progress              │
│ • Stuck detector catches circular behavior       │
│ • exhaustWithPrompt keeps trying                 │
└──────────────────┬──────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────┐
│ Codon 4: Validate & Package                     │
│ • Final `lake build`, count remaining sorries    │
│ • 0 sorry → success summary                     │
│ • >0 sorry → "drop me into your agent" guide    │
└─────────────────────────────────────────────────┘

Output: proof.lean + result.md (+ drop_me_into_your_agent.md if incomplete)
```

### Sentinels

Two sentinels watch the Fill codon (the hard part):

- **Narrator**: Writes human-readable progress updates ("Proved idem, working on comm..."). Fires on debounce every 8s.
- **Stuck Detector**: Watches for circular behavior — repeated `lake build` failures on the same proof, notation drift, agent going in circles. Writes warnings the agent reads via the Sentinel Sweep pattern.

## Prerequisites

**Required tools:**

- **Node.js** (v18+): needed to run Hankweave
- **[Hankweave](https://github.com/SouthBridgeAI/hankweave-runtime)**: `npm install -g hankweave` (or use `npx hankweave`)
- **[elan](https://github.com/leanprover/elan)** (Lean version manager): manages Lean toolchain versions
- **An API key** for your chosen model (`ANTHROPIC_API_KEY` for Claude, `OPENAI_API_KEY` for GPT)

**Installing elan (if you don't have it):**

```bash
# Install elan (Lean version manager)
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh

# Verify it works
source ~/.elan/env  # or restart your shell
lean --version
lake --version
```

The Hank's rig automatically runs `lake exe cache get` to download pre-compiled Mathlib files (~5GB). This takes 2-3 minutes on first run but means `lake build` only compiles your proof, not all of Mathlib.

**Mathlib cache:** The Hank automatically caches Mathlib to `~/.hankweave-lean-cache/` on first run (~~5 min download, ~7GB). Subsequent runs copy from this local cache instead (~~10 seconds). To pre-warm the cache manually:

```bash
# Option 1: Run any test case once (cache is saved automatically)
npx hankweave ./hank.json ./inputs/eq387-implies-eq43 --model haiku --headless -y

# Option 2: Seed from an existing Lean project with Mathlib
mkdir -p ~/.hankweave-lean-cache && cp -r /path/to/your/lean-project/.lake ~/.hankweave-lean-cache/.lake
```

## Quick Start

```bash
# Validate the configuration
npx hankweave ./hank.json ./inputs/eq387-implies-eq43 --validate

# Run with Haiku (cheapest, good for testing)
npx hankweave ./hank.json ./inputs/eq387-implies-eq43 --model haiku --headless -y

# Run with Sonnet (better proofs)
npx hankweave ./hank.json ./inputs/eq387-implies-eq43

# Run with explicit output directory
npx hankweave ./hank.json ./inputs/eq1689-implies-eq2 -o ./my-output
```

## Test Cases

Five test cases of increasing difficulty, extracted from the [equational theories project](https://github.com/teorth/equational_theories):

| Test Case              | Implication    | Difficulty  | Source                                                                       |
| ---------------------- | -------------- | ----------- | ---------------------------------------------------------------------------- |
| `eq387-implies-eq43`   | Eq387 → Eq43   | Easy        | [MathOverflow](https://mathoverflow.net/a/450905/766)                        |
| `eq3744-implies-eq381` | Eq3744 → Eq381 | Easy-Medium | Putnam 1978, Problem A4                                                      |
| `eq953-implies-eq2`    | Eq953 → Eq2    | Medium-Easy | equational_theories blueprint                                                |
| `eq1689-implies-eq2`   | Eq1689 → Eq2   | Medium      | Kisielewicz 1997; [Tao's video](https://www.youtube.com/watch?v=JHEO7cplfk8) |
| `eq1571-implies-eq43`  | Eq1571 → Eq43  | Hard        | Mendelsohn-Padmanabhan                                                       |

Each input directory contains only:

- `informal_proof.md` — The input for the Hank (this is all the agent sees)

Reference formalizations and provenance docs are in `expected/` (kept separate so the agent can't cheat by reading the answer):

- `expected/{test-case}/expected_output.lean` — Known-good reference for validation
- `expected/{test-case}/PROVENANCE.md` — Where we got it and why it's useful

### What's an equational theory proof?

A **magma** is a set with a binary operation `◇`. An **equation** is a universally quantified identity like `x ◇ y = (y ◇ y) ◇ x`. The equational theories project studies which equations imply which others — for example, does every magma satisfying equation 387 also satisfy commutativity (`x ◇ y = y ◇ x`)? Proving this requires algebraic manipulation: specializing variables, deriving intermediate lemmas, and chaining results.

## Results: Model Comparison

All 5 test cases run with 3 different models (15 runs total, fully autonomous, headless):

### Scorecard

All 15 proofs independently verified to compile with `lake build`. See [`results/ANALYSIS.md`](results/ANALYSIS.md) for deep analysis.

| Test Case           | Haiku           | Opus             | GPT-5.4   |
| ------------------- | --------------- | ---------------- | --------- |
| eq387 → eq43        | $0.22           | $0.59            | $0.39     |
| eq953 → eq2         | $0.15           | $0.63            | $0.18     |
| eq3744 → eq381      | $0.11           | $0.49            | $0.24     |
| eq1689 → eq2        | $0.16 (5 sorry) | $1.16            | $0.28     |
| eq1571 → eq43       | $0.65 (3 sorry) | $2.13 (10 sorry) | $0.27     |
| **Total**           | **$1.29**       | **$5.00**        | **$1.36** |
| **Clean (0 sorry)** | **3/5**         | **4/5**          | **5/5**   |

### Key Findings

**GPT-5.4 wins on value.** 5/5 proofs fully formalized for $1.36 total. Every proof, including Tao's Eq1689 benchmark and the hard Eq1571 chain (14 lemmas, 140 lines). Consistent across multiple runs.

**Structure helps weak models most.** Haiku gets 3/5 clean for $1.29 because the skeleton prevents it from going off-track. The two failures have correct structure — a human or stronger model can finish from the generated `drop_me_into_your_agent.md`.

**Even strong models can overthink.** Opus regressed on eq1571 — the sentinel caught it spending 26 minutes _thinking_ without writing code. The exact failure mode Tao described in his video. Structure prevents this for weaker models but a powerful model can defeat it by reasoning internally.

**Sentinels work.** The narrator tracks progress ("3/4 sorries filled, working on lemma3"). The stuck detector catches circular behavior ("agent has been working on eq40 for 1561 seconds without writing code"). Both produce actionable output to `sentinel-notes/`.

**The failures are mathematically honest.** Haiku fails on eq1689 and eq1571 — the exact proofs where Tao himself had to intervene manually. The Hank surfaces where human help is needed, not where the pipeline breaks.

### Example Output: eq387 → eq43 (Complete)

```lean
-- GPT-5.4 output ($0.39, 0 sorry, 35 lines)
import Mathlib.Tactic

class Magma (α : Type _) where
  op : α → α → α

infix:65 " ◇ " => Magma.op

abbrev Equation387 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = (y ◇ y) ◇ x
abbrev Equation43 (G : Type _) [Magma G] := ∀ x y : G, x ◇ y = y ◇ x

namespace EqProof
variable {G : Type _} [Magma G]

lemma star (h : Equation387 G) (x y : G) : (x ◇ x) ◇ y = y ◇ x := by
  exact (h y x).symm

lemma idem (h : Equation387 G) (x : G) : (x ◇ x) ◇ (x ◇ x) = x ◇ x := by
  exact (star h x (x ◇ x)).trans ((h x x).symm)

lemma comm (h : Equation387 G) (x y : G) : (x ◇ x) ◇ (y ◇ y) = (y ◇ y) ◇ (x ◇ x) := by
  simpa [idem h x] using (star h (x ◇ x) (y ◇ y))

lemma op_idem (h : Equation387 G) (x y : G) : (x ◇ x) ◇ (y ◇ y) = x ◇ y := by
  exact (star h x (y ◇ y)).trans ((h x y).symm)

theorem equation387_implies_equation43 (h : Equation387 G) : Equation43 G := by
  intro x y
  calc x ◇ y = (x ◇ x) ◇ (y ◇ y) := (op_idem h x y).symm
       _ = (y ◇ y) ◇ (x ◇ x) := comm h x y
       _ = y ◇ x := op_idem h y x
end EqProof
```

### Example: Sentinel Output (haiku eq1571, stuck detector)

```
## WARNING: Circular behavior

The agent has been working on the same proof for 1561 seconds with increasingly
convoluted reasoning... No actual proof code has been written or tested.

**Suggestion:** Skip eq40 and move to a different lemma (like left_id or eq14).
These may be easier to prove directly, and once established, they might provide
the missing insight needed to return to eq40 with a clearer strategy.
```

The full results for all 15 runs (proof files, formalization plans, sentinel logs) are in [`results/`](results/).

## Creating Your Own Input

To formalize a new proof, create a directory with an `informal_proof.md`:

```markdown
# Equation X implies Equation Y

## Equation Definitions

- **Equation X**: `[definition]` for all x, y, ...
- **Equation Y**: `[definition]` for all x, y, ...

## Goal

Prove that any magma satisfying Equation X also satisfies Equation Y.

## Informal Proof

[Your proof here, with lemma structure if applicable]
```

Then run:

```bash
npx hankweave ./hank.json ./your-input-directory
```

## How This Was Built

This Hank was developed following the [CCEPL process](https://www.southbridge.ai/blog/ccepl-driven-development):

1. **Explored** Tao's video and the equational theories project
2. **Did the task interactively** — formalized eq387→eq43 and eq953→eq2 by hand with Claude Code
3. **Observed what worked** — skeleton/fill split, `lake build` as oracle, namespace for name collisions
4. **Froze it** into this Hank structure
5. **Iterated** — added sentinels, tested on all 5 cases, refined prompts

## Directory Structure

```
tao-formalization-hank/
├── hank.json                          # Hank configuration (4 codons, 2 sentinels)
├── prompts/
│   └── system.md                      # Global system prompt (Lean/magma context)
├── codons/
│   ├── codon-1-analyze/prompt.md      # Analysis & planning
│   ├── codon-2-skeleton/prompt.md     # Skeleton creation
│   ├── codon-3-fill/prompt.md         # Proof filling
│   └── codon-4-validate/prompt.md     # Validation & packaging
├── sentinels/
│   ├── narrator.json                  # Progress narration
│   └── stuck-detector.json            # Circular behavior detection
├── templates/
│   └── lean-project/                  # Lean 4 + Mathlib template
│       ├── lakefile.toml
│       ├── lean-toolchain
│       └── Formalization/
├── inputs/                            # Test case inputs (what the agent sees)
│   ├── README.md
│   ├── eq387-implies-eq43/            # Each contains only informal_proof.md
│   ├── eq953-implies-eq2/
│   ├── eq3744-implies-eq381/
│   ├── eq1689-implies-eq2/
│   └── eq1571-implies-eq43/
├── expected/                          # Reference outputs (for validation, not seen by agent)
│   ├── eq387-implies-eq43/            # expected_output.lean + PROVENANCE.md
│   ├── eq953-implies-eq2/
│   ├── eq3744-implies-eq381/
│   ├── eq1689-implies-eq2/
│   └── eq1571-implies-eq43/
├── results/                           # Benchmark outputs (15 runs: 5 cases × 3 models)
│   ├── ANALYSIS.md                    # Detailed comparison of models and approaches
│   ├── haiku/                         # Claude Haiku results (3/5 clean, $3.25)
│   ├── opus/                          # Claude Opus results (5/5 clean, $13.73)
│   └── gpt54/                         # GPT-5.4 results (5/5 clean, $2.04)
└── README.md                          # This file
```

## Sources & Acknowledgments

- **Terence Tao's video**: ["Formalizing a proof in Lean using Claude Code"](https://www.youtube.com/watch?v=JHEO7cplfk8) — the inspiration for this Hank
- **Equational theories project**: [github.com/teorth/equational_theories](https://github.com/teorth/equational_theories) — all informal proofs and reference formalizations come from here
- **Blueprint (informal proofs)**: `[blueprint/src/chapter/implications.tex](https://github.com/teorth/equational_theories/blob/main/blueprint/src/chapter/implications.tex)`
- **Formalized proofs**: `[equational_theories/Subgraph.lean](https://github.com/teorth/equational_theories/blob/main/equational_theories/Subgraph.lean)`
- **Hankweave**: [github.com/SouthBridgeAI/hankweave-runtime](https://github.com/SouthBridgeAI/hankweave-runtime) — the runtime that executes this Hank
- **Southbridge AI**: [southbridge.ai](https://www.southbridge.ai) — the team behind Hankweave

## License

The informal proofs and equation definitions are from the equational theories project (Apache 2.0). The Hank itself is provided as-is for demonstration purposes.
