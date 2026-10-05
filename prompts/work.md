# Continue Work

Use this during normal implementation after a Draft PR exists.

```text
Continue work on PR #[PR].

Follow AGENTS.md. The linked Issue defines the requested outcome; the PR body owns current execution state; repository facts and checks are evidence.

Before continuing:
1. Read the linked Issue acceptance criteria.
2. Read the PR `Current State` and `Validation`.
3. Inspect the current diff and relevant repository files.
4. Confirm the recorded next action is still correct. If the code contradicts the prose, trust the repository and correct the PR body.

Then continue implementation toward the acceptance criteria.

When execution state materially changes, update the PR body so `Current State` says:
- what is complete,
- what remains,
- any blocker,
- the exact next action if unfinished.

Keep `Validation` accurate as checks are run. Explicitly record important checks that were not run and why.

Do not post routine progress comments. Comment only for exception history or communication as defined in AGENTS.md.

Persist conclusions, evidence, decisions, constraints, blockers, and next actions; do not persist private chain-of-thought.
```
