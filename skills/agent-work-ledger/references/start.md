# Start executable work

Use this path before executable work has entered its normal execution surface. Apply the tracking test from `AGENTS.md`; do not load detailed workflow documentation just to classify routine work.

If the Issue still owns an exploratory initiative whose accepted direction or executable decomposition is materially unsettled, switch to `shape.md` rather than inventing acceptance criteria or treating a candidate solution as committed.

## Repository-changing work

For Issue-backed executable work:

1. Confirm the Issue has a usable objective and acceptance criteria for the concrete delivery slice.
2. Normally create `agent/<issue-number>-<short-slug>` from the appropriate base.
3. Make the first meaningful commit, then open a Draft PR with an Issue closing link in `## Tracking`.

For standalone maintenance:

1. Confirm user intent plus repository evidence define a complete PR-sized work item.
2. Normally create `agent/maintenance-<short-slug>` from the appropriate base.
3. Make the first meaningful commit, then open a Draft PR with `Standalone maintenance: <brief reason or scope>` in `## Tracking`.

For both paths, initialize `Current State` and `Validation`. If implementation was requested, switch to `resume.md` once the execution surface exists.

If an exploratory parent initiative needs a repository-changing research or design slice before the parent should close, first create or identify a concrete executable Issue for that slice; do not use a closing link to the parent when merging the PR would not complete the parent lifecycle.

## Issue-only executable work

When independently tracked executable work produces no repository change, keep execution state on the Issue; do not create an artificial PR.

## Done when

The correct executable surface exists and accurately represents the work, execution has moved to the resume path, or the work has been rerouted to shaping because an executable contract is not yet stable.
