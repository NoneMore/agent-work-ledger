# Prepare a Handoff

Use this before stopping unfinished work or transferring it to another executor.

```text
Prepare PR #[PR] for handoff.

Follow AGENTS.md. Assume the next executor will have no access to this chat or any private reasoning from this session.

Do not write a conversation summary. Instead, inspect the actual repository state and update the PR body into a self-sufficient execution snapshot.

`Current State` must make clear:
- what is complete,
- what remains,
- known blockers or constraints,
- any material implementation decision needed to continue safely,
- the exact next action.

`Validation` must accurately record:
- checks already run and their results,
- checks not run,
- why any important validation remains outstanding.

Use `Notes` only for useful limitations, risks, follow-ups, material decisions, or review focus.

Add a comment only when important historical context would be lost by updating the current-state snapshot alone, or when another person needs notification/action.

Before stopping, compare the written snapshot with the current diff and checks. Repository facts override stale prose.

Persist conclusions, evidence, decisions, constraints, blockers, and next actions. Do not persist private chain-of-thought.
```
