# Start executable work

Use before normal executable execution state exists. Apply the tracking test in `AGENTS.md`; if a PR already exists, route to the applicable existing-PR operation instead of recreating it.

## Repository-changing work

For Issue-backed executable work:

1. Confirm a usable objective and acceptance criteria for the concrete delivery slice; reconcile any authorized Issue-comment input selected under the `AGENTS.md` recovery triggers. If the Issue declares a material `Contract Impact`, identify the authoritative contract source before implementation.
2. Normally create `agent/<issue-number>-<short-slug>`.
3. Make the first meaningful commit, then open a Draft PR with an Issue closing link in `## Tracking`.

For standalone maintenance:

1. Confirm user intent plus repository evidence define a complete PR-sized item.
2. Normally create `agent/maintenance-<short-slug>`.
3. Make the first meaningful commit, then open a Draft PR with `Standalone maintenance: <brief reason or scope>` in `## Tracking`.

Initialize `Current State`, `Validation`, and `Contract Reconciliation`; switch to `resume` when implementation continues. Use `No durable contract change.` unless the work intentionally changes an authoritative product or architecture contract, in which case name the source that must be reconciled before completion.

## Issue-only executable work

Keep execution state on the Issue; do not create an artificial PR.

## Done when

The correct executable surface exists and matches the work, or execution has moved to `resume`.
