# Agent Working Protocol

GitHub is the durable system of record for agent work. Preserve enough state for another agent or human to resume without duplicating routine progress across Issues, comments, and Pull Requests.

## Invariants

1. **Use Issues for work worth tracking independently.** Problems, requests, user-visible outcomes, work needing discussion/coordination, and multi-PR efforts normally deserve an Issue. The decisive test is whether the work needs a lifecycle independent of the current PR; category examples are guidance, not exemptions.
2. **One Issue should be one independently reviewable deliverable.** Split larger work when that improves review or ownership.
3. **All repository changes use `branch -> first meaningful commit -> Draft PR`.** Issue-backed work normally starts on `agent/<issue-number>-<slug>`; standalone maintenance normally starts on `agent/maintenance-<slug>`. Branch naming is a creation convention, not tracking truth.
4. **The PR body owns repository execution state.** `## Tracking` is the canonical tracking declaration; keep `Current State` and `Validation` accurate when state materially changes.
5. **Comments are exceptions, not checkpoints.** Use them only for useful notification/history such as blockers, material decisions, important discoveries, or pause context that does not fit the PR body.
6. **Repository facts override stale prose.** Correct stale canonical state during authorized write work; report mismatches during read-only review.
7. **Do not persist hidden chain-of-thought.** Persist only conclusions, evidence, decisions, constraints, blockers, validation, and next actions useful to future work.

Standalone maintenance is a tracking choice, not a low-risk classification. Use it when the PR itself is the complete public work item. If the work later needs an independent lifecycle, promote it: create an Issue, replace the standalone declaration in `## Tracking` with an Issue closing link, and continue on the existing branch/PR.

For intentionally non-repository work with an Issue and no PR, the Issue is both task definition and execution record.

## Minimum PR contract

A repository-changing PR must contain:

- `## Tracking`: either an Issue closing link or `Standalone maintenance: <brief reason or scope>`,
- `Current State`: what is done, what remains, and the exact next action if unfinished,
- `Validation`: checks actually run and results, including important checks not run.

Before stopping or handing off unfinished work, make sure the canonical execution surface is sufficient to resume without prior chat.

## Recovery budget

Start from the canonical execution surface and expand only when the selected operation needs more evidence:

1. If a PR exists, read its metadata/body first. For Issue-only work, read the Issue execution state.
2. Use `## Tracking` to identify the tracking source. For Issue-backed work, read the linked Issue objective/acceptance criteria whenever the operation will continue implementation or judge intended scope/completion; skip Issue comments/history unless a discrepancy requires them. For standalone work, the PR title/body defines the task scope.
3. When repository behavior matters, read changed filenames/stats, then selected patches, then surrounding source only if needed.
4. Read check summaries only when validation affects the outcome; expand failed jobs/steps only for diagnosis. Read unresolved review feedback only when relevant to the selected operation.
5. Read historical Issue/PR comments only when current canonical state cannot explain a material decision or discrepancy.

Do not preload full diffs, complete CI logs, linked-Issue history, or full comment/review history.
