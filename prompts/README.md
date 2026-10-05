# Operational Prompt Pack

These prompts turn the repository's work-ledger protocol into copyable instructions for common agent lifecycle transitions.

`AGENTS.md` remains authoritative. The files here do not create a second protocol; they provide short entry points that tell an executor which parts of the durable GitHub state to read, update, and verify.

## Choose a prompt

| Situation | Prompt |
| --- | --- |
| Start a new Issue | [`start.md`](./start.md) |
| Continue routine implementation | [`work.md`](./work.md) |
| Record and handle a blocker | [`blocked.md`](./blocked.md) |
| Prepare unfinished work for another executor | [`handoff.md`](./handoff.md) |
| Resume without relying on prior chat | [`resume.md`](./resume.md) |
| Prepare a Draft PR for review | [`ready-for-review.md`](./ready-for-review.md) |
| Review a PR against its Issue | [`review.md`](./review.md) |

## Usage

Replace the bracketed identifier in a prompt, then give the prompt to the agent from the repository checkout or another environment that can read the relevant GitHub artifacts.

Examples:

```text
Work on GitHub Issue #123.
Follow AGENTS.md and prompts/start.md.
```

```text
Resume PR #456.
Follow AGENTS.md and prompts/resume.md.
```

The prompts are intentionally vendor-neutral. They should work with any coding agent that can inspect the repository and GitHub state.

## Design constraints

- GitHub remains the durable source of truth.
- The Issue defines the requested outcome; the PR body owns current execution state.
- Repository diff, commits, and checks are evidence and override stale prose.
- Comments are for exception history, not routine progress logs.
- Persist conclusions, decisions, evidence, constraints, blockers, and next actions; do not persist private chain-of-thought.
- Do not add agent IDs, run IDs, heartbeats, leases, scheduled checkpoints, or a separate state database just to use these prompts.
