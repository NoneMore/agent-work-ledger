# Review a Pull Request

Review is read-only unless fixes are separately authorized.

1. Read the Issue objective/acceptance criteria and PR metadata/body.
2. Read changed filenames/stats before patches. Select files relevant to the Issue and review risk.
3. Inspect per-file patches and surrounding source only where needed to understand behavior.
4. Read validation/check summaries and unresolved actionable review threads. Expand failed logs or historical discussion only when necessary to verify a finding.
5. Ground findings in repository evidence. Treat PR prose/history as context, not stronger evidence than code, checks, or current repository state.
6. Report only actionable findings: concrete location/artifact, observable concern, and minimum correction. Avoid speculative refactors unrelated to the Issue.

Do not mutate the branch, PR body, or review state unless the user separately requests fixes or another write-capable operation.

## Done when

Findings or approval are evidence-based and any remaining validation limits are explicit.
