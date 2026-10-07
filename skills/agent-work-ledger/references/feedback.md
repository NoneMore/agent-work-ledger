# Handle PR feedback

Use this path when PR feedback becomes active work and a write-capable feedback operation is authorized. Feedback may come from GitHub review threads, submitted reviews, PR conversation comments, or actionable findings from a completed review once the user asks to act on them.

1. Recover the canonical PR state and task definition when required. Inspect only the current feedback needed for the operation, plus check summaries when repository changes may be required.
2. Classify each in-scope item before acting: question/discussion, actionable change, evidence-based no-change disposition, or blocker/decision. Existing GitHub feedback is already durable; do not copy it into `Current State` solely for bookkeeping.
3. Respond on the existing GitHub surface when a response is useful or expected. For an actionable change, make the minimum correction and run validation appropriate to it. For a no-change disposition, give concrete evidence. For a blocker or required decision, make the unblock condition and exact next action durable.
4. Update `Current State` / `Validation` only when execution state materially changes. Do not create a synthetic feedback ledger; persist only resulting material execution state when needed for resumability.
5. Re-check current checks and unresolved in-scope feedback after changes or replies. Resolve a review thread only after its concern is corrected or explicitly dispositioned and only with authority. When more implementation or completion work remains, switch to `resume`. Return to `review` only when repository policy or explicit user intent requires another review; otherwise continue discussion if needed or leave the PR at its next separately authorized finalizing action.

## Done when

Every in-scope feedback item has a durable response, disposition, correction, or explicit blocker where a GitHub feedback surface exists; validation reflects any repository changes; canonical current state matches the resulting execution state; and the next applicable resume, review, discussion, decision, or separately authorized finalizing action is explicit.
