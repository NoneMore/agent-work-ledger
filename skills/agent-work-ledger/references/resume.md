# Continue or resume executable work

Use for active executable work with a canonical execution surface. Apply shared rules from `SKILL.md`.

1. Recover the current task definition, execution state, blockers, validation evidence, contract-reconciliation state, and recorded next action.
2. Verify that the recorded next action still follows from durable task state and current repository facts. Identify the smallest concrete remaining work obligation that can responsibly proceed.
3. Route that obligation to the appropriate substantive executor or project capability. The ledger does not perform implementation, design, specification, decomposition, review, or validation-strategy work merely because it is next.
4. After the substantive work returns, replace superseded `Current State` and record only resulting durable conclusions, validation actually performed, blockers, and the next workflow-level action.
5. Keep `Contract Reconciliation` aligned with the resulting execution state; replace `Pending:` with `Updated:` only after the designated source(s) are actually reconciled. If no source has been designated, use `No contract source designated.` rather than creating or selecting one through the ledger workflow. Do not copy the current contract into the PR body.
6. If another substantive outcome is required before execution can continue or completion can be judged, make that requirement and its durable input explicit as the next action rather than manufacturing the outcome in the ledger.
7. If the operation changes, reroute through `SKILL.md` rather than redefining lifecycle boundaries here. If a required transition lacks authority, leave it as the exact next action.

## Done when

The requested executable increment has been coordinated to completion and durable state matches the returned evidence, or the next required substantive outcome, lifecycle path, blocker, or authorized transition is explicit.