# Agent Working Protocol

GitHub is the durable system of record for agent work. Preserve enough state for another agent or human to resume without prior chat, without duplicating routine progress across Issues, comments, and Pull Requests.

## Invariants

1. **Use Issues for work that needs an independent lifecycle.** Problems, requests, user-visible outcomes, coordination, and multi-PR efforts normally qualify. Routine repository maintenance may be PR-only when the PR is a complete public work item.
2. **One Issue should be one independently reviewable deliverable.** Split larger work when that improves review or ownership.
3. **All repository changes use `branch -> first meaningful commit -> Draft PR`.** Issue-backed work normally starts on `agent/<issue-number>-<slug>`; standalone maintenance normally starts on `agent/maintenance-<slug>`. Branch naming records how work started; tracking state is canonical elsewhere.
4. **The PR body owns repository execution state.** `## Tracking` declares the tracking mode. `Current State` and `Validation` are a current replacement snapshot, not an append-only log: remove superseded state instead of accumulating history.
5. **Validation depth follows change risk.** Use repository-defined affected validation for narrow changes and stronger validation for broad, dependency/build/CI, security-sensitive, or unclassifiable changes. Do not reduce expensive validation solely from an agent-authored declaration.
6. **Comments are exceptions, not checkpoints.** Use them only for notification or history that does not belong in current state, such as blockers, material decisions, important discoveries, or pause context.
7. **Repository facts override stale prose.** Correct stale canonical state during authorized write work; report mismatches during read-only review.
8. **Do not persist hidden chain-of-thought.** Persist conclusions, evidence, decisions, constraints, blockers, validation, and next actions useful to future work.

Standalone maintenance is a tracking choice, not a risk classification. If it later needs an independent lifecycle, create an Issue and replace the standalone declaration in `## Tracking` with an Issue closing link; keep the existing branch. For intentionally non-repository work with an Issue and no PR, the Issue is both task definition and execution record.

## Minimum PR contract

Every repository-changing PR must contain:

- `## Tracking`: exactly one of an Issue closing link or `Standalone maintenance: <brief reason or scope>`,
- `Current State`: what is done, what remains, and the exact next action if unfinished,
- `Validation`: checks actually run and results, including important checks not run.

Before stopping or handing off unfinished work, make the canonical execution surface sufficient to resume without prior chat.

## Recovery budget

Recover context progressively; do not preload evidence for later filtering:

1. Read the canonical execution surface first: PR metadata/body when a PR exists, otherwise Issue execution state.
2. Use `## Tracking` to identify task scope. For Issue-backed implementation or completion judgments, read the linked Issue objective/acceptance criteria; for standalone work, use the PR title/body.
3. When repository behavior matters, expand `changed filenames/stats -> selected patches -> surrounding source` only as needed.
4. When validation or review affects the operation, expand `check summary -> failed job/step/log slice` and unresolved actionable review feedback only as needed.
5. Read historical Issue/PR discussion only when current canonical state cannot explain a material decision or discrepancy.

Do not use full diffs, complete CI logs, linked-Issue history, or full comment/review history as default recovery shortcuts.
