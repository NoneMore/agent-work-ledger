# Start executable work

Use before normal executable execution state exists. Apply the tracking test in `AGENTS.md`; if a PR already exists, route to the applicable existing-PR operation instead of recreating it.

If the Issue still owns exploratory work rather than a concrete delivery contract, switch to `shape` instead of inventing acceptance criteria or treating a candidate direction as committed.

## Repository-changing work

For Issue-backed executable work:

1. Confirm a usable objective and acceptance criteria for the concrete delivery slice; reconcile any authorized Issue-comment input selected under the `AGENTS.md` recovery triggers.
2. Normally create `agent/<issue-number>-<short-slug>`.
3. Make the first meaningful commit, then open a Draft PR with an Issue closing link in `## Tracking`.

For standalone maintenance:

1. Confirm user intent plus repository evidence define a complete PR-sized item.
2. Normally create `agent/maintenance-<short-slug>`.
3. Make the first meaningful commit, then open a Draft PR with `Standalone maintenance: <brief reason or scope>` in `## Tracking`.

Initialize `Current State` and `Validation`; switch to `resume` when implementation continues.

## Issue-only executable work

Keep execution state on the Issue; do not create an artificial PR.

## Done when

The correct executable surface exists and matches the work, execution has moved to `resume`, or the work has been rerouted to `shape` because an executable contract is not yet stable.
