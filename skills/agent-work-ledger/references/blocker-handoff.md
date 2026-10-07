# Blocker or handoff

Use this path when work cannot continue normally or must be left for another executor. Verify any blocker with the recovery budget from `AGENTS.md`.

## Blocker

Update the canonical execution surface with the blocker, unblock condition, validation impact, remaining useful work, and exact next action. Use the PR body for PR-backed work and the Issue for Issue-only work. Before a PR exists, do not create a second status surface solely to hold blocker state.

Continue independent useful work when appropriate; otherwise stop at the blocker boundary.

## Handoff

Make the canonical surface sufficient to resume without prior chat: completed work, remaining work, blockers/constraints, validation state, material decisions needed to continue safely, and the exact next action.

Use comments only when notification or durable history is needed beyond current state.

## Done when

The unblock condition is explicit, or a new executor can resume safely from durable state.
