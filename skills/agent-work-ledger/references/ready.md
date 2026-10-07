# Prepare for Ready for Review

Use this path when a Draft PR should be normalized and validated for review. For an already non-Draft PR returning after feedback handling, use `feedback` and then `review` instead of cycling through this path.

1. Confirm exactly one tracking mode. For Issue-backed work, ensure every closing-linked Issue's acceptance criteria are satisfied or incomplete items are explicit; for standalone work, confirm the scope still fits that mode.
2. Read check summaries and current PR feedback relevant to readiness, then apply the recovery budget from `AGENTS.md` only far enough to account for intended scope, validation, and material blockers. Do not load older/resolved feedback unless a discrepancy requires it.
3. Normalize the PR replacement snapshot: accurate `Current State`, validation actually performed, and only material limitations or incomplete items. Feedback blocks readiness only when it remains actionable and material to intended scope or repository policy.
4. Apply the repository's authoritative readiness policy. Move Draft to Ready only with explicit user intent or clear repository delegation.

Never claim validation that was not performed.

## Done when

The PR satisfies readiness policy, has no unaccounted material feedback blocker, and its tracking/current state/validation match evidence. Without transition authority, leave it correctly prepared in Draft with the next action explicit.
