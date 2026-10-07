# Start executable work

Use before normal executable execution state exists. Apply the tracking test in `AGENTS.md`; if a PR already exists, route to the applicable existing-PR operation instead of recreating it.

If the Issue still owns an exploratory initiative whose accepted direction or executable decomposition is materially unsettled, switch to `shape.md` rather than inventing acceptance criteria or treating a candidate solution as committed.

## Repository-changing work

For Issue-backed executable work:

1. Confirm a usable objective and acceptance criteria for the concrete delivery slice; reconcile any authorized Issue-comment input selected under the `AGENTS.md` recovery triggers.
2. Normally create `agent/<issue-number>-<short-slug>` from the appropriate base.
3. Make the first meaningful commit, then open a Draft PR with an Issue closing link in `## Tracking`.

For standalone maintenance:

1. Confirm user intent plus repository evidence define a complete PR-sized item.
2. Normally create `agent/maintenance-<short-slug>` from the appropriate base.
3. Make the first meaningful commit, then open a Draft PR with `Standalone maintenance: <brief reason or scope>` in `## Tracking`.

Initialize `Current State` and `Validation`; switch to `resume` when implementation continues.

If an exploratory parent initiative needs a repository-changing research or design slice before the parent should close, first create or identify a concrete executable Issue for that slice; do not use a closing link to the parent when merging the PR would not complete the parent lifecycle.

## Issue-only executable work

Keep execution state on the Issue; do not create an artificial PR.

## Done when

The correct executable surface exists and matches the work, execution has moved to `resume`, or the work has been rerouted to shaping because an executable contract is not yet stable.
