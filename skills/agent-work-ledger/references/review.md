# Coordinate Pull Request review

Use when PR review is required by repository policy or explicitly requested. Review coordination is read-only by default.

1. Recover intended scope from `## Tracking` and the task definition, plus the minimum current PR/check/feedback state needed to establish review context.
2. Determine whether substantive review is currently required and whether the review executor has enough durable input to perform it. Do not substitute ledger policy for technical or product review judgment.
3. Route the PR and relevant scope/context to the appropriate review executor or capability. Substantive findings, no-findings conclusions, and technical correctness judgments belong to that executor.
4. Preserve the resulting review state without duplicating native GitHub feedback: actionable findings, unresolved questions, validation limits, or a no-material-findings result when one was actually produced. A finding that already exists in a review thread or PR comment remains durable there.
5. Route authorized correction work to `feedback` or active execution as appropriate. Do not create an automatic review cycle; another review occurs only when repository policy or explicit user intent requires it.
6. Do not approve, request changes, resolve threads, move Draft to Ready, merge, or otherwise mutate finalizing GitHub state without the required authority.

## Done when

The required substantive review outcome has been obtained and its workflow consequences are clear, or the missing review input/executor/authority is explicit as the next action.