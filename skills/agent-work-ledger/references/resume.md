# Reconcile active executable-work state

Use for active executable work with a canonical execution surface. Apply shared rules from `SKILL.md`.

1. Recover the current task definition, execution snapshot, blockers, validation evidence, contract-reconciliation state, feedback state when relevant, and recorded next action.
2. Compare that snapshot with current authoritative GitHub facts. Correct stale `Current State`, `Validation`, blockers, feedback consequences, or `Contract Reconciliation` when the evidence establishes a different state and mutation is authorized.
3. Verify that the recorded next action still follows from established task state. Replace it only when the new next action follows without substantive product, design, implementation, review, validation-strategy, or decomposition judgment.
4. Do not execute remaining substantive work and do not select or invoke anyone or anything to execute it. If an unmet substantive outcome is still required, leave that outcome as the exact next action.
5. Replace `Pending:` with `Updated:` only after authoritative evidence establishes that the designated source was reconciled. If durable behavior change is established but no source has been designated, use `No contract source designated.` Do not create or choose a contract source.
6. If completion or the next state depends on unresolved judgment, authority, or ownership, leave the dependency explicit and ask the user when a choice is required.
7. If the state operation changes, switch through `SKILL.md` rather than redefining boundaries here.

## Done when

The canonical execution snapshot matches authoritative evidence and the next outstanding workflow or substantive obligation is explicit; no substantive work is performed merely to make the ledger advance.
