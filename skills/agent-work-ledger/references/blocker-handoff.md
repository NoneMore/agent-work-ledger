# Blocker or handoff

Use this path when work cannot continue normally or must be left for another executor. Verify any blocker with the recovery budget from `AGENTS.md`.

## Blocker

Update the canonical surface with the blocker, unblock condition, remaining useful work, and the exact next action or uncertainty-reducing question. For executable PR-backed work, also record validation impact in the PR body. For Issue-only or exploratory initiative work, keep current shaping/execution state on the Issue. Before a PR exists, do not create a second status surface solely to hold blocker state.

Continue independent useful work when appropriate; otherwise stop at the blocker boundary.

## Handoff

Make the canonical surface sufficient to resume without prior chat. For executable work, preserve completed work, remaining work, blockers/constraints, validation state, material decisions, and the exact next action. For exploratory initiative work, preserve current understanding, useful evidence, open questions, candidate versus accepted directions, blockers/decision dependencies, and the smallest useful next step.

Use comments only when notification or durable history is needed beyond current state.

## Done when

The unblock condition is explicit, or a new executor can safely recover the relevant execution or shaping state from the durable canonical surface.
