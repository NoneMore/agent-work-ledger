# Review a Pull Request

Review is read-only unless fixes are separately authorized.

1. Establish intended scope from `## Tracking` and the task definition.
2. Read changed filenames/stats, check summaries, and unresolved actionable review feedback before approving or reporting no findings. Select patches/source by scope or review risk; expand failed jobs/log slices, referenced source, or history only as needed to verify concerns.
3. Report only actionable findings: concrete location or artifact, observable concern, and the minimum correction. Make remaining validation limits explicit.
4. Do not mutate the branch, PR body, or review state unless the user separately requests a write-capable operation.

## Done when

Findings or approval account for current checks and unresolved actionable feedback, are evidence-based, and make remaining validation limits explicit.
