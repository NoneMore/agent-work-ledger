# Start executable work

Use before normal executable execution state exists. Apply the tracking test in `SKILL.md`; if a PR already exists, route to the applicable existing-PR operation instead of recreating it.

## Repository-changing work

For Issue-backed executable work:

1. Confirm a usable objective and acceptance criteria for the concrete delivery slice; reconcile any authorized Issue-comment input selected under the `SKILL.md` recovery triggers. If an explicit `Contract Impact` applies and names a source already designated by the user or established project policy, use that source for reconciliation. If no source is designated, do not create or designate one as part of the ledger workflow.
2. Normally create `agent/<issue-number>-<short-slug>`.
3. Make the first meaningful commit, then open a Draft PR with an Issue closing link in `## Tracking`.

For standalone maintenance:

1. Confirm user intent plus repository evidence define a complete PR-sized item.
2. Normally create `agent/maintenance-<short-slug>`.
3. Make the first meaningful commit, then open a Draft PR with `Standalone maintenance: <brief reason or scope>` in `## Tracking`.

Initialize `Current State`, `Validation`, and `Contract Reconciliation` using the applicable state defined in `SKILL.md`; use `Pending: <source(s)>` only when designated source(s) still need reconciliation, and `No contract source designated.` when durable behavior changes but no source has been designated. Switch to `resume` when implementation continues.

## Issue-only executable work

Keep execution state on the Issue; do not create an artificial PR.

## Done when

The correct executable surface exists and matches the work, or execution has moved to `resume`.
