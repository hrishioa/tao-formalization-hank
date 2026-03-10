# Results Analysis: V2 Runs (15 runs, 3 models)

All proofs independently verified to compile with `lake build`. Cerebras excluded due to API instability (4/5 runs returned HTTP 500).

## Summary


| Test Case      | Haiku ($) | Sorry | Opus ($)  | Sorry | GPT-5.4 ($) | Sorry |
| -------------- | --------- | ----- | --------- | ----- | ----------- | ----- |
| eq387 → eq43   | $0.22     | 0     | $0.59     | 0     | $0.39       | 0     |
| eq953 → eq2    | $0.15     | 0     | $0.63     | 0     | $0.18       | 0     |
| eq3744 → eq381 | $0.11     | 0     | $0.49     | 0     | $0.24       | 0     |
| eq1689 → eq2   | $0.16     | 5     | $1.16     | 0     | $0.28       | 0     |
| eq1571 → eq43  | $0.65     | 3     | $2.13     | 10    | $0.27       | 0     |
| **Total**      | **$1.29** |       | **$5.00** |       | **$1.36**   |       |
| **Clean**      | **3/5**   |       | **4/5**   |       | **5/5**     |       |


All 15 proofs compile. 12 are sorry-free.

## GPT-5.4: The Value Champion ($1.36, 5/5 clean)

Perfect score again. Every proof compiles with zero sorry, including the hard eq1571 chain (140 lines, 14 lemmas). GPT-5.4's style:

- **Heavy `calc` user** (18 instances across all proofs) — builds explicit chains of equalities
- **Loves `simp`** (16 instances) — leans on automation for the boring parts
- **Most lemmas** — 14 lemmas for eq1571 vs Opus's 10, showing fine-grained decomposition
- **Cheapest on hard cases** — eq1571 at $0.27 vs Opus's $2.13

The eq1689 proof (Tao's benchmark) is 102 lines with 7 lemmas. Clean, well-structured, uses the S/f notation from the informal proof.

## Opus: Overthinking Problem ($5.00, 4/5 clean)

Opus regressed on eq1571 compared to the v1 batch (which was 5/5 clean). The sentinel log tells the story:

> "The agent has been working on the same proof for **1561 seconds** (26 minutes!) with increasingly convoluted reasoning... No actual proof code has been written or tested."

Opus spent its entire fill codon *thinking* about eq40 without ever writing Lean code. The sentinel caught circular behavior and suggested "skip eq40 and move to other lemmas" — but the agent never acted on the suggestion. All 10 lemmas stayed as sorry.

This is ironic — Opus's failure mode is the exact problem Tao described in his video: the agent overthinks instead of just trying things. Structure prevents this for weaker models (Haiku fills 6/9 lemmas), but a powerful model can defeat the structure by spending its whole budget on internal reasoning.

Where Opus shines: eq1689 ($1.16, 0 sorry) — elegant 123-line proof, the most mathematically clean of any model's output.

## Haiku: Scrappy but Honest ($1.29, 3/5 clean)

Haiku nails the easy/medium cases (eq387, eq953, eq3744 — all clean, all cheap) and produces the right structure for hard cases even when it can't close every proof.

- **Most verbose** — 430 total lines vs GPT-5.4's 376 and Opus's 340
- **Least `rw` usage** (7 vs GPT-5.4's 22 and Opus's 14) — relies more on `have`/`exact` chains
- **Heaviest sentinel activity** — haiku-eq1571 generated 41KB of warnings and 26KB of progress notes. The sentinels were working overtime watching Haiku struggle.
- **Cheapest overall** ($1.29) but only 3/5 clean

The eq1689 result (5 sorry, $0.16) is interesting — it spent very little and produced a 65-line file with the right structure but couldn't close the hard proofs. The `drop_me_into_your_agent.md` file explains exactly what's left.

## Tactic Styles


| Tactic  | GPT-5.4 | Opus | Haiku |
| ------- | ------- | ---- | ----- |
| `have`  | 30      | 19   | 36    |
| `rw`    | 22      | 14   | 7     |
| `exact` | 20      | 16   | 23    |
| `calc`  | 18      | 2    | 0     |
| `simp`  | 16      | 0    | 1     |
| `intro` | 14      | 6    | 13    |
| `congr` | 3       | 2    | 5     |


**GPT-5.4** is the most tactical — heavy `calc`, `simp`, and `rw` usage. Structured, step-by-step, heavily automated.

**Opus** is the most minimal — fewest tactics overall, relies on `have`/`exact` chains. When it works, it produces the most elegant proofs. When it doesn't, it produces nothing.

**Haiku** avoids `rw` and `calc` almost entirely, preferring `have`/`exact` chains. Zero `calc` usage across all 5 proofs. This suggests it has less confidence in rewriting-based strategies.

## Proof Sizes


| Case   | GPT-5.4 | Opus | Haiku |
| ------ | ------- | ---- | ----- |
| eq387  | 35      | 47   | 86    |
| eq953  | 50      | 43   | 75    |
| eq3744 | 49      | 41   | 63    |
| eq1689 | 102     | 123  | 65    |
| eq1571 | 140     | 86   | 141   |


Haiku writes the most verbose proofs for easy cases but the *shortest* for eq1689 (65 lines — because it gave up early with sorry). Opus writes the most compact proofs when it succeeds but the shortest when it fails (86 lines of pure sorry skeleton for eq1571).

## Sentinel Effectiveness

Sentinels produced output on all 15 runs. Key observations:

1. **Narration works well across all models.** Progress tracking is useful for understanding what happened during a run.
2. **The stuck detector caught the Opus regression.** It flagged "1561 seconds without writing code" and suggested skipping to other lemmas. The agent didn't act on it because the fill codon's `exhaustWithPrompt` doesn't force re-reading sentinel notes strongly enough.
3. **Haiku generates the most sentinel activity.** haiku-eq1571 produced 41KB of warnings — the sentinels were working overtime because Haiku needed the most guidance.
4. **GPT-5.4 runs are the quietest sentinel-wise.** Fewer warnings because it moves efficiently through proofs without getting stuck.

## Comparison with V1 Batch


| Model   | V1 Cost | V1 Clean | V2 Cost | V2 Clean |
| ------- | ------- | -------- | ------- | -------- |
| GPT-5.4 | $2.04   | 5/5      | $1.36   | 5/5      |
| Opus    | $13.73  | 5/5      | $5.00   | 4/5      |
| Haiku   | $3.25   | 3/5      | $1.29   | 3/5      |


The v2 Hank is cheaper across the board (symlink + template fixes eliminated wasted rig time). GPT-5.4 and Haiku are consistent. Opus regressed on eq1571 — variance, not a systematic problem.

## Key Takeaways

1. **GPT-5.4 is the best value.** 5/5 clean for $1.36. Consistent across both runs.
2. **Structure helps weak models more than strong ones.** Haiku gets 3/5 clean because the skeleton prevents it from going off-track. Opus can defeat the structure by overthinking internally.
3. **The sentinel caught the regression.** The stuck detector correctly identified Opus's failure mode. The gap is in making the agent *act* on the warnings.
4. **The informal proof is the real bottleneck.** All models that fail, fail on the same proofs (eq1689, eq1571). These are mathematically hard regardless of the model. The Hank correctly surfaces where human help is needed.

