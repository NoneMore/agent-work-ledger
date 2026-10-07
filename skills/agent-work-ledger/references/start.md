# Start work

Use this path before work has entered its normal execution surface. Apply the tracking test from `AGENTS.md`; do not load detailed workflow documentation just to classify routine work.

An externally opened Issue is still ordinary Issue-backed work; do not recreate it. If a PR already exists for the work, the execution surface already exists, so route to `resume`, `review`, `feedback`, or another applicable path instead of creating a replacement branch/PR.

## Repository-changing work

For Issue-backed work:

1. Confirm the Issue has a usable objective and acceptance criteria. If the current operation is triggered by or explicitly references Issue comments, account for any authorized material change to scope, constraints, a decision, or a blocker and reconcile the resulting task definition/state into the Issue when authorized rather than treating comments as a second canonical definition.
2. Normally create `agent/<issue-number>-<short-slug>` from the appropriate base.
3. Make the first meaningful commit, then open a Draft PR with an Issue closing link in `## Tracking`.

For standalone maintenance:

1. Confirm user intent plus repository evidence define a complete PR-sized work item.
2. Normally create `agent/maintenance-<short-slug>` from the appropriate base.
3. Make the first meaningful commit, then open a Draft PR with `Standalone maintenance: <brief reason or scope>` in `## Tracking`.

For both paths, initialize `Current State` and `Validation`. If implementation was requested, switch to `resume.md` once the execution surface exists.

## Issue-only work

When independently tracked work produces no repository change, keep execution state on the Issue; do not create an artificial PR. Material Issue-comment decisions or blockers that must survive handoff should be reflected in the Issue's canonical task/execution state when authorized.

## Done when

The correct execution surface exists and accurately represents the work, or execution has moved to the resume path.
