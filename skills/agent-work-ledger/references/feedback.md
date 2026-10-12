# Reconcile PR feedback state

Use when PR feedback state is active work. Sources include review threads, submitted reviews, PR comments, and review findings already present on GitHub. Existing feedback is durable; do not mirror it solely for bookkeeping.

1. Recover canonical PR/task state and only current feedback/check evidence needed to establish workflow state.
2. Identify mechanical facts that are already explicit: which items remain unresolved, which have an explicit durable disposition, and whether existing feedback has already changed execution state.
3. Do not decide contested technical/product correctness, produce a no-change justification, correct code, choose validation, select an owner, or invoke another capability.
4. Update `Current State`/`Validation` only when authoritative evidence establishes a resulting execution-state change. If feedback still requires evaluation, correction, clarification, evidence, or a decision, leave that unmet outcome explicit.
5. Respond or resolve a thread only when that GitHub mutation is explicitly authorized and the required disposition is already established; do not create the disposition merely to make the thread resolvable.
6. Re-check current native feedback after authorized state mutations. If ownership, authority, or disposition remains unclear, ask the user rather than guessing.

## Done when

Canonical execution state matches durable feedback evidence and every still-unresolved feedback obligation is explicit without the ledger performing or dispatching the substantive work needed to close it.
