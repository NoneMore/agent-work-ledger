# Prepare for Ready for Review

Use this before moving a Draft PR into review.

```text
Prepare PR #[PR] for Ready for Review.

Follow AGENTS.md. Do not mark the PR Ready for Review until the durable artifacts accurately represent a reviewable state.

Before changing PR status:
1. Re-read the linked Issue and evaluate every acceptance criterion against the implementation.
2. Inspect the final diff for unintended or unrelated changes.
3. Run the appropriate tests, lint, type checks, builds, or other validation available for this repository.
4. Update `Validation` with the exact checks and outcomes. Explicitly state important validation that was not run and why.
5. Update `Current State` so it matches the repository and contains no stale remaining work. If anything is intentionally incomplete, make that explicit and record the exact next action.
6. Use `Notes` only for material risks, limitations, follow-ups, decisions, or review focus.
7. Confirm the PR links its Issue with a closing keyword.

If a required acceptance criterion is not satisfied or a required blocker remains, keep the PR in Draft.

Do not claim validation that was not performed. Persist concise evidence and conclusions, not private chain-of-thought.
```
