# Blocker or handoff

Use this path when work cannot continue normally or must be left for another executor.

## Blocker

Verify the blocker with the smallest relevant evidence, then update the canonical execution surface:

- PR-backed work: record the blocker, unblock condition, validation impact, remaining useful work, and exact next action in `Current State`.
- Issue-only work: record the equivalent state on the Issue.
- Pre-PR work: do not create a second status surface. Comment only when another person must act or useful history would otherwise be lost; standalone maintenance does not need an Issue solely to hold a blocker.

Continue independent useful work when appropriate; otherwise stop at the blocker boundary.

## Handoff

Build the handoff from current durable evidence, not chat history. Ensure the canonical surface states completed work, remaining work, blockers/constraints, validation state, material decisions needed to continue safely, and the exact next action.

Read historical discussion only when current state cannot explain a needed decision. Use comments only for necessary notification or history that does not fit current state.

## Done when

The unblock condition is explicit, or a new executor can resume safely without prior chat.
