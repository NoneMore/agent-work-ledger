# Start work

Use this path for an executable Issue that has not entered its normal execution surface.

## Repository-changing work

1. Confirm the Issue supplies a usable objective and acceptance criteria; recover only context needed to execute safely.
2. Create `agent/<issue-number>-<short-slug>` from the appropriate base.
3. Make the first meaningful change and commit it before opening a Draft PR.
4. Open the Draft PR linked with `Closes #N`, `Fixes #N`, or `Resolves #N`.
5. Initialize an accurate PR body with `Current State` and `Validation`; include `Notes` only when useful.
6. If the user requested full implementation, continue by loading `resume.md` rather than stopping at setup.

Do not add routine claim/progress comments.

## Issue-only non-repository work

When no repository change or PR is appropriate, execute against the Issue and keep its execution state there. Do not create an artificial PR only to satisfy the repository workflow shape.

## Done when

The correct execution surface exists and accurately represents the work, or the requested full implementation has moved into the resume path.
