# Reconcile durable work state

Use for all existing work state, regardless of which evidence domain changed.

1. Read the canonical surface plus the minimum evidence allowed by the `SKILL.md` recovery budget.
2. Separate facts from outstanding outcomes; evidence establishes only what it actually shows.
3. Correct stale canonical state when clear and authorized. Never upgrade `requested`, `planned`, `delegated`, or `expected` into `in progress` or `done`.
4. Derive mechanical next actions from established state. If the next outcome requires substantive work or judgment, record it as outstanding rather than producing or dispatching it.
5. Ask the user only when the requested ledger mutation itself cannot safely proceed without a user decision or authority.

Apply the same reconciliation path across these domains:

- **Initiatives:** record established understanding, evidence, questions, decisions, child relationships, parent-level acceptance, and next action without creating the substantive design/specification/decomposition.
- **Repository/check/validation:** inspect only enough source/check/log evidence to establish an objective workflow fact; bounded blocker diagnosis is allowed, remediation and invented validation requirements are not.
- **Review/feedback:** treat native review/comment/thread state as evidence; do not perform technical review or invent a contested disposition. Respond/resolve only when authorized and the disposition already exists.
- **Blockers/handoff:** record established blocker facts, known unblock condition, material validation impact, useful independent work, and exact next action. If resumability requires a missing durable surface, switch to `references/establish.md`.
- **Contract/readiness/completion:** apply the canonical states and lifecycle gates in `SKILL.md`; do not create/designate contract truth or infer substantive acceptance merely to advance state.

Done when canonical state matches the evidence and all remaining obligations/unknowns are explicit.
