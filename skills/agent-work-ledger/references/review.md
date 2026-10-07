# Review a Pull Request

Review is optional unless repository policy or explicit user intent requires it, and read-only by default.

1. Establish intended scope from `## Tracking` and the task definition.
2. Apply the `AGENTS.md` recovery budget: inspect changed-file stats, checks, current unresolved actionable feedback, then only the patches/source or diagnostic evidence needed by scope/risk.
3. Report actionable findings with concrete location/artifact, observable concern, minimum correction, and remaining validation limits. If a new finding is not already durable GitHub state, say so.
4. Do not mutate GitHub from review. Route authorized action on findings to `feedback`; without actionable feedback, do not create an automatic review cycle.

## Done when

There is an evidence-based findings/no-findings result, current checks and unresolved actionable feedback are accounted for, and any required follow-up is routed explicitly.
