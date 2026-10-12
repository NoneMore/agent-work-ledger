# Reconcile durable work state

Use for all existing work state: initiative shaping state, repository execution, validation, contract reconciliation, review/feedback, blockers/handoff, readiness, and completion.

## Reconcile

1. Read the canonical surface and the minimum relevant evidence under the `SKILL.md` recovery budget.
2. Separate **facts** from **outstanding outcomes**. A commit/check/review/comment/decision is evidence only for what it actually establishes.
3. Correct stale canonical state when the evidence is clear and the mutation is authorized.
4. Keep unknowns explicit. Do not upgrade `requested`, `planned`, `delegated`, or `expected` into `in progress` or `done`.
5. Derive mechanical next actions when they follow directly from established state. If the next action requires substantive design/implementation/review/product judgment, record that outcome as outstanding instead of producing it.
6. Ask the user only when the ledger action they requested cannot safely proceed without a user decision or authority. Unknown ownership or a missing substantive executor is otherwise just durable state.

## Evidence domains

- **Initiatives:** record established understanding, evidence, open questions, accepted decisions, child relationships, remaining parent-level acceptance, and established next action. Do not create the substantive design/specification/decomposition.
- **Repository/check evidence:** inspect only enough filenames, patches, source, checks, or log slices to establish an objective state fact. Bounded factual diagnosis is allowed when needed to classify a blocker or workflow consequence; designing or executing the remedy is not.
- **Validation:** record what ran/results and explicit required validation still outstanding. Do not invent additional validation requirements.
- **Review/feedback:** treat native review/comment/thread state as evidence. Do not perform the technical review or invent a contested disposition. Respond/resolve only when authorized and the disposition is already established.
- **Blockers/handoff:** record the blocker, known unblock condition, relevant validation impact, established independent work, and exact next action. A resumable handoff requires a durable canonical surface; if none exists and durability is required, establish one through `references/establish.md`.
- **Contract reconciliation:** use:
  - `No reconciliation indicated.` when authoritative task/project state establishes no current reconciliation obligation;
  - `No contract source designated.` when an obligation is established but no source is designated;
  - `Pending: <source(s)>` while designated source updates remain;
  - `Updated: <source(s)>` after evidence establishes reconciliation.
  Do not create/designate a contract source merely to satisfy the field.

## Readiness and completion

Move Draft to Ready only when authoritative state shows no known blocking prerequisite and the mutation is authorized. Missing required review, required validation, unresolved material feedback, unfinished required work, or pending contract reconciliation remain explicit blockers.

For Issue-backed work, treat acceptance criteria as complete only when authoritative evidence establishes completion; do not infer substantive acceptance merely from a merged or existing repository change. For initiatives, child completion does not imply parent acceptance.

Done when canonical state matches the evidence and all remaining obligations/unknowns are explicit.
