# Handle a Blocker

Use this when progress is materially blocked.

```text
Handle the blocker on PR #[PR].

Follow AGENTS.md. Do not merely record "blocked".

First verify the blocker against the repository, checks, available configuration, and linked Issue constraints. Do not speculate about unavailable inputs.

Update the PR `Current State` with:
- what cannot proceed,
- the concrete reason,
- concise evidence,
- the condition or action that would unblock the work,
- any work that can still continue independently,
- the exact next action.

Update `Validation` if the blocker prevents a check from running; state what was not run and why.

Add a PR comment only if another person must act, the blocker needs discussion/notification, or the historical rationale would be lost from a current-state-only snapshot. Keep that comment concise and actionable.

If useful work can continue without the blocked dependency, continue it. Do not mark the PR Ready for Review while required acceptance criteria remain blocked.

Persist conclusions and evidence, not private chain-of-thought.
```
