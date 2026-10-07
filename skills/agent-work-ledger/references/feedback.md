# Handle PR feedback

Use when PR feedback is active work and write-capable feedback handling is authorized. Sources include review threads, submitted reviews, PR comments, and review findings the user asks to act on. This authority permits responses and minimum in-scope corrections, not thread resolution, review-state changes, Draft -> Ready, merge/close, or other finalizing transitions.

1. Recover canonical PR/task state as needed and only the current feedback/check evidence required.
2. Classify each in-scope item: question/discussion, actionable change, evidence-based no-change, or blocker/decision. Existing GitHub feedback is already durable; do not mirror it for bookkeeping.
3. Respond on the existing surface when useful/expected. Make minimum corrections with appropriate validation; support no-change with evidence; make blocker/decision unblock conditions and next action durable.
4. Update `Current State`/`Validation` only when execution state materially changes; do not create a synthetic feedback ledger.
5. Re-check current checks and unresolved in-scope feedback. Resolve threads only after correction/disposition and with authority. Switch to `resume` for remaining implementation/completion, to `review` only when required/requested, otherwise continue discussion or leave the next separately authorized action explicit.

## Done when

Every in-scope item has a durable response/disposition/correction/blocker as applicable, validation and canonical state match resulting execution state, and the next operation is explicit.
