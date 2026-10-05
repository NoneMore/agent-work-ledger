# Resume Work

Use this when a new session or executor takes over an existing PR.

```text
Resume work on PR #[PR].

Follow AGENTS.md. Assume you have no reliable knowledge from previous chat sessions.

Recover state from durable artifacts in this order:
1. Read the linked Issue for the objective, acceptance criteria, context, and constraints.
2. Read the PR body for `Current State`, `Validation`, and useful notes.
3. Inspect the current diff, commits, and relevant repository files.
4. Check CI/check results and unresolved review feedback when relevant.
5. Read historical Issue/PR comments only if the current state is insufficient or a material decision needs context.

Verify the PR description against the actual repository. If code or checks contradict the prose, trust the repository and correct the PR body before continuing.

Identify the exact next action from the current state. If it is stale or underspecified, derive a concrete next action from the Issue acceptance criteria and repository evidence, then update the PR body.

Continue implementation without recreating already completed investigation unless verification is necessary.

Keep routine progress out of comments. Persist conclusions, evidence, decisions, constraints, blockers, and next actions; do not persist private chain-of-thought.
```
