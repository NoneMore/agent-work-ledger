# Address review feedback

Use this path only when actionable review findings exist and fixes have been separately authorized.

1. Recover the canonical PR state, task definition when required, current head/check summaries, and unresolved actionable review feedback. Include any user-supplied findings that are in scope even if they are not yet durable GitHub state.
2. Reconcile every in-scope finding: make the minimum correction, or explicitly disposition it as requiring no change with concrete evidence.
3. Run validation appropriate to the corrections and replace stale `Current State` / `Validation` with repository facts. If an actionable finding remains unresolved when stopping, record it in `Current State` with the exact next action; use a comment only when notification, discussion, or durable history is also useful.
4. Re-check current check summaries and unresolved actionable review feedback after the changes. When the fixes are ready to be judged again, switch to the review path; do not approve, merge, or otherwise finalize without separate authority.

If the operation lacks authority to persist an outstanding finding, do not silently lose it: stop and make the durability limit explicit.

## Done when

Every in-scope finding is corrected or explicitly dispositioned, validation reflects the resulting head, durable current state accounts for anything still unresolved, and the next review action is explicit.
