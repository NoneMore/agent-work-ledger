# Coordinate PR feedback

Use when PR feedback is active work and feedback handling is authorized. Sources include review threads, submitted reviews, PR comments, and review findings the user asks to act on. Existing GitHub feedback is already durable; do not mirror it solely for bookkeeping.

1. Recover canonical PR/task state and only the current feedback/check evidence needed to determine the next workflow action.
2. Identify which in-scope feedback items already have a durable disposition and which still require substantive evaluation, correction, clarification, evidence, or a decision. The ledger may classify workflow state, but it must not manufacture the technical/product disposition when substantive judgment is required.
3. Route substantive evaluation to the appropriate review/domain capability. Route confirmed correction work to the appropriate implementation/execution capability. Route decision needs to the authorized decision-maker. Preserve evidence-based no-change outcomes only when a substantive executor has established them.
4. Respond on the existing GitHub surface when useful or expected and authorized. Update `Current State`/`Validation` only when resulting execution state materially changes; do not create a synthetic feedback ledger.
5. Re-check current checks and unresolved in-scope feedback after resulting changes or replies. Resolve threads only after correction/disposition and with authority. Switch to `resume` for remaining implementation/completion, to `review` only when required/requested, otherwise continue discussion or leave the next separately authorized action explicit.
6. This route may coordinate and persist feedback work; it does not itself perform substantive code correction, choose validation strategy, or decide contested technical correctness.

## Done when

Every in-scope item has a durable disposition, routed substantive action, correction result, decision request, or blocker as applicable; canonical execution state matches the result; and the next operation is explicit.