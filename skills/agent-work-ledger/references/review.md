# Reconcile Pull Request review state

Use when review state matters because repository policy or explicit user intent requires review.

1. Recover intended scope from `## Tracking` and the task definition, plus the minimum native PR review/check/feedback state needed to determine whether a required review exists and what durable consequences it already established.
2. Do not inspect code to produce findings, decide technical correctness, select a reviewer, or invoke a review capability.
3. If required review has not occurred, leave `review required` or the equivalent exact next action outstanding. Do not mark review as routed, in progress, or complete merely because someone should perform it.
4. If native GitHub review/comment state already establishes findings, no-findings, requested changes, questions, or another explicit disposition, reflect only the workflow consequences that follow without additional substantive judgment. Do not duplicate the feedback itself into the PR body merely for bookkeeping.
5. When the consequence of review evidence is ambiguous or requires a substantive disposition, leave it unresolved and ask the user if a decision is required.
6. Approving, requesting changes, resolving threads, moving Draft to Ready, or merging are GitHub state mutations and require the applicable authority; do not infer the substantive basis for them.

## Done when

Ledger review state matches native GitHub evidence and any missing review, unresolved disposition, or separately authorized transition is explicit.
