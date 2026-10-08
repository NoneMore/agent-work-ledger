# Agent Working Protocol

GitHub is the durable system of record for agent work. Preserve enough state for another agent or human to resume without prior chat; do not duplicate routine progress across surfaces.

## Invariants

1. **Use an Issue when work needs an independent lifecycle.** Problems, requests, user-visible outcomes, coordination, and multi-PR efforts normally qualify. Routine maintenance may be PR-only when its PR is a complete public work item. For exploratory shaping, create or adopt an Initiative Issue only when durable tracking is explicitly requested or required by repository policy; otherwise do not manufacture tracking solely because shaping is occurring.
2. **Distinguish exploratory initiatives from executable Issues.** Executable Issues should be independently reviewable deliverables; exploratory initiatives may retain the durable problem/decision lifecycle while executable child work evolves beneath them. Do not infer executable commitment from detail, completeness, or a next step: candidate directions require explicit authorized acceptance, and implementation-local unknowns may remain.
3. **All repository changes use `branch -> first meaningful commit -> Draft PR`.** Issue-backed branches normally use `agent/<issue-number>-<slug>`; standalone maintenance uses `agent/maintenance-<slug>`. Branch names record origin, not current tracking mode.
4. **Canonical ownership is singular.** The Issue owns task definition and Issue-only state, including exploratory shaping; once a concrete repository-changing slice has a PR, its body owns that slice's execution state. `## Tracking` declares tracking mode; `Current State` and `Validation` are replacement snapshots, not logs.
5. **Validation follows change risk.** Use affected validation for narrow changes and stronger validation for broad, dependency/build/CI, security-sensitive, or unclassifiable changes. Reduce expensive validation only from repository facts or authoritative rules.
6. **GitHub inputs keep native roles.** Issue = tracked task definition or initiative; Issue comments = discussion/input; PR = execution artifact; PR comments/reviews/threads = feedback. Treat authorship as provenance, not authority; adopt existing Issues/PRs in place. User instructions provide intent, authority, or context rather than another ledger surface; mutations still require user intent, repository policy, or clear delegation.
7. **Comments are communication/history, not checkpoints or current-state stores.** When authorized Issue-comment input materially changes task definition, Issue-only state, or exploratory shaping state, update the Issue; PR-backed execution state stays in the PR body. Do not mirror native input/feedback merely for bookkeeping.
8. **Repository facts override stale prose.** Correct stale canonical state during authorized write work; report mismatches during read-only review.
9. **Do not persist hidden chain-of-thought.** Persist only conclusions, evidence, decisions, constraints, blockers, validation, and next actions useful to future work.

Standalone maintenance is a tracking choice, not a risk class. If it later needs an independent lifecycle, create an Issue, replace the standalone `## Tracking` declaration with Issue closing link(s), and keep the branch.

`Ready for Review` is a PR state, not a lifecycle operation. Before leaving Draft, account for tracking mode, intended scope, linked-Issue acceptance criteria when applicable, current state, validation, and material unresolved feedback. Transition only with explicit user intent or clear repository delegation.

## Minimum PR contract

Every repository-changing PR must contain:

- `## Tracking`: exactly one mode — Issue closing link(s), or `Standalone maintenance: <brief reason or scope>`,
- `Current State`: done, remaining work, and exact next action if unfinished,
- `Validation`: checks actually run/results, including important checks not run.

Before stopping or handing off unfinished work, make the canonical execution surface sufficient to resume without prior chat.

## Recovery budget

Load only what the current operation needs:

1. **Canonical state:** PR metadata/body when a concrete PR execution surface exists; otherwise the relevant Issue execution or shaping state when one exists.
2. **Task definition:** for Issue-backed executable implementation/completion judgments, read every closing-linked Issue's objective/acceptance criteria. Inspect Issue comments only when the operation is triggered by or explicitly references them, canonical state points to a pending comment/decision, or user intent/repository policy requires them; never scan comments merely to discover possible changes. For exploratory initiative work with an Initiative Issue, use its current canonical shaping state; for untracked shaping, use the current request/context and selected evidence without creating tracking solely for recovery. For standalone work, use PR title/body.
3. **Repository evidence:** `changed filenames/stats -> selected patches -> surrounding source`, as needed.
4. **Validation/feedback:** `check summary -> failed job/step/log slice`; current unresolved PR feedback or feedback blockers only when relevant.
5. **History:** older/resolved Issue or PR discussion only when canonical state plus current input/evidence cannot explain a material decision or discrepancy.

Do not preload full diffs, CI logs, linked-Issue history, or comment/review history.
