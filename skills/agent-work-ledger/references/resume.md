# Continue or resume

Use this path for active work that already has its canonical execution surface.

1. Read the Issue objective/acceptance criteria and the current PR metadata/body (or Issue execution state for intentionally Issue-only work).
2. Verify the recorded next action against durable repository evidence instead of assuming prose is current.
3. Inspect changed filenames/stats first; expand only the patches and surrounding source relevant to the next action.
4. Check validation summaries and unresolved review feedback only when relevant to the work being resumed.
5. Continue from the smallest concrete next action without repeating completed investigation unless verification is necessary.
6. Update the canonical execution surface only when state materially changes. Keep validation claims explicit about checks run and important checks not run.

If repository facts conflict with recorded state, trust the facts and correct stale canonical state during authorized write work. Read historical comments only if the discrepancy cannot otherwise be explained.

Do not fetch the complete PR diff, all CI logs, or full conversation history as a recovery shortcut.

## Done when

The requested scope or increment is complete and durable state matches evidence, or another lifecycle path becomes necessary.
