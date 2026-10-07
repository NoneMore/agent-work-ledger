# Handle PR feedback

Use this path when PR feedback becomes active work and a write-capable feedback operation is authorized. Feedback may come from review threads, submitted reviews, PR conversation comments, or user-supplied input.

1. Recover the canonical PR state and task definition when required. Discover current feedback from unresolved review threads, relevant submitted reviews, and PR conversation comments without using recency as a cutoff; then inspect only the items needed for the operation. Include user-supplied feedback and check summaries when repository changes may be required.
2. Classify each in-scope item before acting: question/discussion, actionable change, evidence-based no-change disposition, or blocker/decision. Existing GitHub feedback is already durable; do not copy it into `Current State` solely for bookkeeping.
3. Respond on the existing GitHub surface when a response is useful or expected. For an actionable change, make the minimum correction and run validation appropriate to it. For a no-change disposition, give concrete evidence. For a blocker or required decision, make the unblock condition and exact next action durable.
4. Update `Current State` / `Validation` only when execution state materially changes. If active off-GitHub feedback or a material execution consequence is not otherwise recoverable from GitHub when stopping, persist enough canonical state to resume without prior chat.
5. Re-check current checks and unresolved in-scope feedback after changes or replies. Resolve a review thread only after its concern is corrected or explicitly dispositioned and only with authority. Switch to review only when repository policy or explicit user intent requires it; otherwise continue discussion if needed or leave the PR ready for a separately authorized merge.

## Done when

Every in-scope feedback item has a durable response, disposition, correction, or explicit blocker; validation reflects any repository changes; canonical current state matches the resulting execution state; and the next applicable review, discussion, decision, or separately authorized merge action is explicit.
