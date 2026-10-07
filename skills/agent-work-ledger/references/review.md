# Review a Pull Request

Review is read-only unless fixes are separately authorized.

1. Read PR metadata/body and establish intended scope from `## Tracking`. For Issue-backed work, read the linked Issue objective/acceptance criteria; skip Issue comments/history by default.
2. Read changed filenames/stats, then inspect only patches/source selected by scope or review risk.
3. Read validation/check summaries and unresolved actionable review threads. Expand failed logs, referenced source, or historical discussion only when needed to verify a finding.
4. Prefer repository evidence over PR prose when they conflict.
5. Report only actionable findings: concrete location/artifact, observable concern, and minimum correction. Avoid speculative refactors outside the intended scope.

Do not mutate the branch, PR body, or review state unless the user separately requests a write-capable operation.

## Done when

Findings or approval are evidence-based and remaining validation limits are explicit.
