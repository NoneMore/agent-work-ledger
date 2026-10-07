# Prepare for Ready for Review

Use this path when a Draft PR should be normalized and validated for review.

1. Determine the tracking source. Re-check linked Issue acceptance criteria when an Issue exists; otherwise verify the standalone-maintenance declaration and PR scope are accurate.
2. Inspect all changed filenames/stats. Expand patches/source for changes relevant to the intended scope and for any changed file not clearly explained by it; avoid a full diff unless the PR is demonstrably small.
3. Read check summaries and expand failures only as needed. Run appropriate validation when authorized and feasible.
4. Resolve or account for unresolved actionable review feedback when relevant.
5. Normalize the PR body: choose exactly one tracking mode, remove stale remaining-work text, make `Current State` accurate, record validation actually performed, and note material limitations/incomplete items only when they exist.
6. Apply the repository's authoritative readiness policy; do not invent a stricter gate.
7. Move Draft to Ready only when explicit user intent or clear repository delegation permits it.

Never claim validation that was not performed.

## Done when

The PR satisfies repository readiness policy and its tracking/current state/validation match evidence. If transition authority is absent, leave it correctly prepared in Draft with the next action explicit.
