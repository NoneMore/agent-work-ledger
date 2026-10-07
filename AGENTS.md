# Agent Working Protocol

GitHub is the durable system of record for agent work. Preserve enough durable state for another agent or human to resume without prior chat; do not duplicate routine progress across Issues, comments, and Pull Requests.

## Invariants

1. **Use an Issue when work needs an independent lifecycle.** Problems, requests, user-visible outcomes, coordination, and multi-PR efforts normally qualify. Routine maintenance may be PR-only when its PR is a complete public work item.
2. **One Issue should be one independently reviewable deliverable.** Split larger work when that improves review or ownership.
3. **All repository changes use `branch -> first meaningful commit -> Draft PR`.** Issue-backed branches normally use `agent/<issue-number>-<slug>`; standalone maintenance uses `agent/maintenance-<slug>`. Branch names record how work started, not current tracking mode.
4. **The PR body owns repository execution state.** `## Tracking` declares tracking mode. `Current State` and `Validation` are replacement snapshots, not append-only logs; remove superseded state.
5. **Validation follows change risk.** Use affected validation for narrow changes and stronger validation for broad, dependency/build/CI, security-sensitive, or unclassifiable changes. Reducing expensive validation requires repository facts or authoritative rules; an agent-authored declaration is insufficient.
6. **Comments are exceptions, not checkpoints.** Use them only for notification or durable history outside current state, such as blockers, material decisions, discoveries, or pause context.
7. **Repository facts override stale prose.** Correct stale canonical state during authorized write work; report mismatches during read-only review.
8. **Do not persist hidden chain-of-thought.** Persist only conclusions, evidence, decisions, constraints, blockers, validation, and next actions useful to future work.

Standalone maintenance is a tracking choice, not a risk classification. If it later needs an independent lifecycle, create an Issue, replace its `## Tracking` declaration with an Issue closing link, and keep the branch. For Issue-only work, the Issue is both task definition and execution record.

## Minimum PR contract

Every repository-changing PR must contain:

- `## Tracking`: exactly one tracking mode — Issue-backed with one or more Issue closing links, or `Standalone maintenance: <brief reason or scope>`,
- `Current State`: what is done, what remains, and the exact next action if unfinished,
- `Validation`: checks actually run and results, including important checks not run.

Before stopping or handing off unfinished work, make the canonical execution surface sufficient to resume without prior chat.

## Recovery budget

Load only what the current operation needs:

1. **Canonical state:** PR metadata/body when a PR exists; otherwise Issue execution state.
2. **Task definition:** for Issue-backed implementation or completion judgments, read linked Issue objective/acceptance criteria; for standalone work, use PR title/body.
3. **Repository evidence:** `changed filenames/stats -> selected patches -> surrounding source`, only as needed.
4. **Validation/review evidence:** `check summary -> failed job/step/log slice` and unresolved actionable review feedback, only when relevant.
5. **History:** read Issue/PR discussion only when current canonical state cannot explain a material decision or discrepancy.

Do not preload full diffs, complete CI logs, linked-Issue history, or full comment/review history.
