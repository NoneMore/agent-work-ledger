# Prepare for Ready for Review

Use this path when a Draft PR should be normalized and validated for review.

1. Re-check the Issue acceptance criteria.
2. Inspect changed filenames/stats, then the final patches/source relevant to those criteria; avoid a full diff unless the PR is demonstrably small.
3. Read check summaries and expand failures only as needed. Run appropriate validation when authorized and feasible.
4. Resolve or account for unresolved actionable review feedback when relevant.
5. Normalize the PR body: remove stale remaining-work text, make `Current State` accurate, record validation actually performed, and note material limitations/incomplete items only when they exist.
6. Apply the repository's authoritative readiness policy; do not invent a stricter gate.
7. Move Draft to Ready only when explicit user intent or clear repository delegation permits it.

Never claim validation that was not performed.

## Done when

The PR satisfies repository readiness policy and its current state/validation match evidence. If transition authority is absent, leave it correctly prepared in Draft with the next action explicit.
