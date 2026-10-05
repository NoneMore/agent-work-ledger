# agent-work-ledger

A lightweight GitHub-native work ledger for human + agent collaboration.

The core model is simple:

- **Issues define the work** — objective, acceptance criteria, context, constraints.
- **Pull Requests track execution** — current state, validation, and handoff.
- **Comments are exceptions** — blockers, material decisions, important discoveries, or pause notes.
- **GitHub Projects show portfolio progress** — without becoming a second source of execution truth.

The workflow is designed so a new agent can resume work without access to previous chat history, while keeping routine process overhead low.

## Start here

1. Read [`AGENTS.md`](./AGENTS.md).
2. Create one independently reviewable Issue through the **Agent Task** form.
3. For repository changes, create `agent/<issue-number>-<slug>` and open a **Draft PR early** with `Closes #<issue>`.
4. Treat the PR body as the single in-progress execution snapshot.
5. Do not post routine progress checkpoints; comment only for blockers, material decisions, important discoveries, or pause/handoff information that does not fit cleanly in the PR body.
6. Before Ready for Review, record validation and complete the handoff.

See [`docs/AGENT_WORKFLOW.md`](./docs/AGENT_WORKFLOW.md) for the lifecycle.

## Recommended GitHub Project fields

Create one Project for the repository and keep the board small:

| Field | Suggested values |
| --- | --- |
| Status | Inbox, Ready, In Progress, Blocked, Review, Done |
| Priority | P0, P1, P2, P3 |
| Workstream | frontend, backend, infra, research, docs |
| Risk | low, medium, high |
| Iteration | your sprint / cycle |

Use Project fields for cross-task workflow state. Reserve labels for stable classification such as `type:bug`, `type:feature`, `area:infra`, `needs-human`, or `agent-ready`.

## Repository contents

- `AGENTS.md` — minimal operating protocol for agents
- `docs/AGENT_WORKFLOW.md` — lifecycle, exception notes, recovery, and handoff model
- `.github/ISSUE_TEMPLATE/agent-task.yml` — lightweight task intake
- `.github/pull_request_template.md` — execution snapshot and handoff record
- `.github/workflows/agent-governance.yml` — lightweight Issue-linkage / handoff checks

## Design principles

1. No meaningful work without an Issue.
2. One Issue should represent one independently reviewable deliverable.
3. The Issue defines the task; the PR owns execution state.
4. Routine progress should not require comments or duplicated status updates.
5. Extra logging is reserved for exceptions and information needed for safe resumption.
6. Preserve useful decisions and evidence; do not dump hidden chain-of-thought or raw model reasoning.

## Bootstrap

This repository's first workflow implementation is tracked in Issue #1 and PR #2.
