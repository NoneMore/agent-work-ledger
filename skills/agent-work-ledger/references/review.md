# Review a Pull Request

Review is read-only unless a write-capable feedback operation is separately authorized.

1. Establish intended scope from `## Tracking` and the task definition.
2. Read changed filenames/stats, check summaries, and current unresolved actionable PR feedback before approving or reporting no findings. Select patches/source by scope or review risk; expand failed jobs/log slices, referenced source, or older/resolved discussion only as needed to verify concerns.
3. Report only actionable findings: concrete location or artifact, observable concern, and the minimum correction. Make remaining validation limits explicit. If a new finding is not already durable GitHub state, make that durability status explicit.
4. Do not mutate the branch, PR body, comments, threads, or review state from the review path. If the user asks to act on findings or other PR feedback, switch to `feedback`.

## Done when

Findings or approval account for current checks and unresolved actionable feedback, are evidence-based, make remaining validation limits explicit, and do not imply that non-durable findings were persisted during read-only review.
