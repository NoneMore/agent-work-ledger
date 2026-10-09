# Continue or resume executable work

Use for active executable work with a canonical execution surface. Apply shared rules from `AGENTS.md`.

1. Verify the recorded next action against the executable task definition and smallest relevant evidence, including any explicit `Contract Impact` that constrains the delivery.
2. Execute the smallest concrete next action; replace superseded `Current State` and record only validation actually performed.
3. Keep `Contract Reconciliation` aligned with the states in `AGENTS.md`; replace `Pending:` with `Updated:` only after the pending source(s) are reconciled. Do not invent a source or copy the contract into the PR body.
4. If the operation changes, reroute through `SKILL.md` rather than redefining lifecycle boundaries here.
5. If a required transition lacks authority, leave it as the exact next action.

## Done when

The requested executable increment is complete and durable state matches evidence, or the next required lifecycle path or authorized transition is explicit.
