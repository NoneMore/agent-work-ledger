# Start executable work

Use before normal executable execution state exists. Apply the tracking test in `SKILL.md`; if a PR already exists, route to the applicable existing-PR operation instead of recreating it.

## Repository-changing work

For Issue-backed executable work:

1. Confirm that the concrete delivery slice has enough durable definition for the requested execution to proceed. Read the objective, acceptance criteria, selected authorized Issue-comment input, and any explicit `Contract Impact` that materially constrains the delivery. If a designated contract source applies, preserve that relationship for reconciliation.
2. If the task definition is materially missing, contradictory, or ambiguous, identify the smallest substantive clarification, specification, design, or decomposition outcome required next. Do not invent that outcome merely to make the work executable.
3. Once execution is sufficiently defined, normally create `agent/<issue-number>-<short-slug>`.
4. Make the first meaningful commit through the appropriate substantive executor, then open a Draft PR with an Issue closing link in `## Tracking`.

For standalone maintenance:

1. Confirm user intent plus repository evidence define a complete PR-sized tracking item. This is a tracking judgment, not authority for the ledger to choose the substantive implementation.
2. Normally create `agent/maintenance-<short-slug>`.
3. Route the first meaningful repository change to the appropriate substantive executor, then open a Draft PR with `Standalone maintenance: <brief reason or scope>` in `## Tracking`.

Initialize `Current State`, `Validation`, and `Contract Reconciliation` using the applicable state defined in `SKILL.md`; use `Pending: <source(s)>` only when designated source(s) still need reconciliation, and `No contract source designated.` when a substantive executor has established a durable behavior change but no source has been designated.

Switch to `resume` once an active execution surface exists and substantive work continues.

## Issue-only executable work

Keep coordination and execution state on the Issue; do not create an artificial PR. Route substantive work to the appropriate executor and persist the resulting state on the Issue.

## Done when

The correct executable surface exists and matches the work, a missing substantive prerequisite is explicit, or execution has moved to `resume`.