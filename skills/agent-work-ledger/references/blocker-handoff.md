# Blocker or handoff

Use when work cannot continue normally or must pass to another executor. Verify blockers with the `AGENTS.md` recovery budget.

## Blocker

Record on the canonical surface the blocker, unblock condition, remaining useful work, and exact next action. For executable PR-backed work, also record validation impact in the PR body; for Issue-only or exploratory work, keep state on the Issue. Before a PR exists, do not create a second status surface solely to hold blocker state.

Continue independent useful work when appropriate; otherwise stop at the blocker boundary.

## Handoff

Make the canonical surface sufficient to resume without prior chat. Preserve the current durable execution or shaping state, material blockers/constraints, validation when applicable, and the next useful action.

Use comments only when notification or durable history is needed beyond current state.

## Done when

The unblock condition is explicit, or another executor can safely recover the relevant execution or shaping state from the canonical surface.
