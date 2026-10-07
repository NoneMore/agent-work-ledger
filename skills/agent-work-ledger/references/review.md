# Review a Pull Request

Review is optional unless repository policy or explicit user intent requires it, and is read-only by default.

1. Establish intended scope from `## Tracking` and the task definition.
2. Read changed filenames/stats, check summaries, and current unresolved actionable PR feedback before reporting findings or no findings. Select patches/source by scope or review risk; expand failed jobs/log slices, referenced source, or older/resolved discussion only as needed to verify concerns.
3. Report only actionable findings: concrete location or artifact, observable concern, and the minimum correction. Make remaining validation limits explicit. If a new finding is not already durable GitHub state, make that durability status explicit.
4. Do not mutate the branch, PR body, comments, threads, or review state from the review path. If actionable findings should be handled, switch to `feedback`. If no actionable feedback remains, do not create another review cycle: a Draft PR may proceed through `ready`; an already non-Draft PR proceeds to the next operation required by repository policy or user intent.

## Done when

The review has an evidence-based findings or no-findings result, accounts for current checks and unresolved actionable feedback, makes remaining validation limits explicit, and leaves any required follow-up routed to `feedback`, `ready`, or the next policy- or user-required operation.
