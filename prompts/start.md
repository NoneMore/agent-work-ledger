# Start Work

Use this when beginning implementation for an existing executable Issue.

```text
Work on GitHub Issue #[ISSUE].

Follow AGENTS.md. Treat GitHub as the durable source of truth and do not rely on prior chat context.

Before editing code:
1. Read the Issue completely, especially the objective, acceptance criteria, context, constraints, and dependencies.
2. Inspect the relevant repository state and existing tests/docs.
3. Identify any ambiguity or blocker that prevents safe execution. Do not invent missing requirements.

If the task is actionable:
1. Create or use `agent/[ISSUE]-<short-slug>`.
2. Make the first meaningful repository change before opening a PR.
3. Open a Draft PR linked with `Closes #[ISSUE]` (or an equivalent closing keyword).
4. Use the PR body as the single current execution snapshot with `Current State` and `Validation`.
5. Continue implementation from the Issue acceptance criteria.

Keep routine progress out of comments. Update the PR body when execution state materially changes.

Persist only useful conclusions, evidence, decisions, constraints, blockers, and next actions. Do not persist private chain-of-thought.
```
