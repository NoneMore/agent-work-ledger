# Continue or resume

Use this path for active work that already has its canonical execution surface.

1. Determine the tracking source. For Issue-backed work, read the Issue objective/acceptance criteria. For standalone maintenance, read the declaration plus PR title/body to establish intended scope. For intentionally Issue-only work, read the Issue execution state.
2. Read the current PR metadata/body when a PR exists.
3. Re-check whether the tracking mode still fits the work. If standalone maintenance now needs an independent lifecycle, promote it when authorized by creating an Issue and replacing the standalone declaration in `## Tracking` with an Issue closing link. Keep the existing branch; branch naming is not canonical tracking state. If promotion is required but not authorized, report that transition as the blocker/next action.
4. Verify the recorded next action against durable repository evidence instead of assuming prose is current.
5. Inspect changed filenames/stats first; expand only the patches and surrounding source relevant to the next action.
6. Check validation summaries and unresolved review feedback only when relevant to the work being resumed.
7. Continue from the smallest concrete next action without repeating completed investigation unless verification is necessary.
8. Update the canonical execution surface only when state materially changes. Keep validation claims explicit about checks run and important checks not run.

If repository facts conflict with recorded state, trust the facts and correct stale canonical state during authorized write work. Read historical comments only if the discrepancy cannot otherwise be explained.

Do not fetch the complete PR diff, all CI logs, or full conversation history as a recovery shortcut.

## Done when

The requested scope or increment is complete and durable state matches evidence, or another lifecycle path becomes necessary.
