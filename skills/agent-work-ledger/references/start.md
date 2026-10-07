# Start work

Use this path when work has not yet entered its normal execution surface.

## Choose tracking first

Create or use an Issue when the work should exist independently of a PR: for example a problem/request, user-visible outcome, discussion/coordination item, multi-PR effort, migration, risk, or follow-up worth tracking on its own. The deciding question is whether the work needs its own lifecycle for prioritization, discussion, acceptance, continuation across PRs, or later follow-up.

Use standalone maintenance when the repository change itself is the complete public work item. Dependency maintenance, CI/build/release changes, internal refactors, tests, documentation upkeep, developer tooling, formatting, and repository metadata commonly fit this path, but those categories are examples rather than automatic exemptions. This is a tracking decision, not a claim that the change is low risk.

## Repository-changing work

For Issue-backed work:

1. Confirm the Issue supplies a usable objective and acceptance criteria; recover only context needed to execute safely.
2. Create `agent/<issue-number>-<short-slug>` from the appropriate base.
3. Make the first meaningful change and commit it before opening a Draft PR.
4. Open the Draft PR linked with `Closes #N`, `Fixes #N`, or `Resolves #N` in `## Tracking`.

For standalone maintenance:

1. Confirm the user intent plus repository evidence is sufficient to define the maintenance scope without a separate public work item.
2. Create `agent/maintenance-<short-slug>` from the appropriate base.
3. Make the first meaningful change and commit it before opening a Draft PR.
4. Open the Draft PR with `Standalone maintenance: <brief reason or scope>` in `## Tracking`.

Branch names are creation conventions only. If standalone work later develops independent tracking value, create an Issue when authorized, replace the standalone declaration with an Issue closing link, and continue on the existing branch/PR rather than renaming it solely for tracking consistency. If creating the Issue is outside current authority, record or report the needed promotion instead of pretending the standalone classification still fits.

For both paths, initialize an accurate PR body with `Current State` and `Validation`; include `Notes` only when useful. If the user requested full implementation, continue by loading `resume.md` rather than stopping at setup.

Do not add routine claim/progress comments.

## Issue-only non-repository work

When an Issue is worth tracking but no repository change or PR is appropriate, execute against the Issue and keep its execution state there. Do not create an artificial PR only to satisfy the repository workflow shape.

## Done when

The correct execution surface exists and accurately represents the work, or the requested full implementation has moved into the resume path.
