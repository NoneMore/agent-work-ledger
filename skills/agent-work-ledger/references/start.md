# Establish executable-work state

Use before normal executable execution state exists. Apply the tracking test in `SKILL.md`; if a PR already exists, use the applicable existing-PR state operation instead of recreating it.

## Repository-changing work

For Issue-backed executable work:

1. Recover the objective, acceptance criteria, selected authorized Issue-comment input, and any explicit `Contract Impact` relevant to tracking or reconciliation.
2. If the task definition is materially missing, contradictory, or ambiguous, make the unresolved prerequisite explicit on the canonical surface when one exists. Do not clarify, specify, design, decompose, or choose who should do so. Ask the user when the required decision, owner, or authority is unclear.
3. Once the work is sufficiently defined by authoritative input, create `agent/<issue-number>-<short-slug>` when authorized and useful.
4. Do not manufacture a repository change merely to advance the workflow. After a first meaningful commit exists, open a Draft PR with the Issue closing link in `## Tracking` and initialize the minimum PR snapshot.

For standalone maintenance:

1. Confirm from user intent and repository facts that the PR itself is sufficient tracking state; do not infer substantive implementation choices.
2. Create `agent/maintenance-<short-slug>` when authorized and useful.
3. After a first meaningful commit exists, open a Draft PR with `Standalone maintenance: <brief reason or scope>` in `## Tracking` and initialize the minimum PR snapshot.

Initialize `Current State`, `Validation`, and `Contract Reconciliation` only from authoritative evidence. Do not mark work, validation, or contract changes as performed merely because they are expected.

Switch to `resume` once an active execution surface exists.

## Issue-only executable work

Keep execution state on the Issue; do not create an artificial PR. Reflect only state established by authoritative evidence and leave unmet substantive work as the exact next action.

## Done when

The correct tracking/execution surface exists and accurately reflects established state, or the missing prerequisite preventing that state transition is explicit.
