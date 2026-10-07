# Start work

Use this path before work has entered its normal execution surface. Apply the tracking test from `AGENTS.md`; do not reload detailed workflow documentation just to classify routine work.

## Repository-changing work

For Issue-backed work:

1. Confirm the Issue has a usable objective and acceptance criteria.
2. Normally create `agent/<issue-number>-<short-slug>` from the appropriate base.
3. Make the first meaningful commit, then open a Draft PR with an Issue closing link in `## Tracking`.

For standalone maintenance:

1. Confirm user intent plus repository evidence define a complete PR-sized work item.
2. Normally create `agent/maintenance-<short-slug>` from the appropriate base.
3. Make the first meaningful commit, then open a Draft PR with `Standalone maintenance: <brief reason or scope>` in `## Tracking`.

For both paths, initialize `Current State` and `Validation`; add `Notes` only when useful. Branch naming is a creation convention, not tracking truth. If standalone work later needs an independent lifecycle, promote it according to `AGENTS.md` without renaming the existing branch solely for tracking consistency.

If the user requested implementation rather than setup only, switch to `resume.md` after the execution surface exists.

## Issue-only work

When independently tracked work produces no repository change, keep execution state on the Issue; do not create an artificial PR.

## Done when

The correct execution surface exists and accurately represents the work, or execution has moved to the resume path.
