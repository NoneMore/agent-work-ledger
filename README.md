# agent-work-ledger

A lightweight GitHub-native work ledger for human + agent collaboration.

The core model is simple:

- **Issues define the work** — objective, acceptance criteria, context, constraints.
- **Pull Requests track execution** — current state and validation, with notes only when useful.
- **Comments are exceptions** — communication or history for blockers, material decisions, important discoveries, or pause notes.
- **GitHub Projects show portfolio progress** — without becoming a second source of execution truth.

The workflow is designed so a new agent can resume work without access to previous chat history, while keeping routine process overhead low.

## Start here

1. Read [`AGENTS.md`](./AGENTS.md).
2. Create one independently reviewable Issue through the **Agent Task** form.
3. For repository changes, create `agent/<issue-number>-<slug>` and make the first meaningful commit.
4. Open a **Draft PR** linked with `Closes #<issue>` and treat its body as the single in-progress execution snapshot.
5. Keep `Current State` and `Validation` accurate when state materially changes.
6. Do not post routine progress checkpoints; comment only when useful communication or history is needed.
7. Before Ready for Review, ensure the PR is resumable and validation is recorded.

See [`docs/AGENT_WORKFLOW.md`](./docs/AGENT_WORKFLOW.md) for the lifecycle.

## Operational Skill

[`skills/agent-work-ledger/SKILL.md`](./skills/agent-work-ledger/SKILL.md) packages the reusable execution behavior as an Agent Skill. It is intended for agents that are starting, continuing, recovering, blocking, handing off, preparing, or reviewing work under this ledger protocol.

`AGENTS.md` remains the authoritative workspace policy. The Skill does not duplicate live task state or create another orchestration layer; it reads the Issue, PR, repository, checks, and comments as needed, then selects the smallest lifecycle path from that durable evidence.

The Skill uses the open Agent Skills packaging shape (`<skill-name>/SKILL.md`) so compatible runtimes can discover or install it without vendor-specific prompt files. Runtimes without Skill support can still follow `AGENTS.md` and `docs/AGENT_WORKFLOW.md` directly.

## Recommended GitHub Project setup

Start with one field only:

| Field | Suggested values |
| --- | --- |
| Status | Inbox, Ready, In Progress, Blocked, Review, Done |

Add fields such as `Priority` or `Iteration` only when the project genuinely benefits from maintaining them. Prefer stable labels such as `type:*` and `area:*` over duplicating the same classification in Project fields.

## Repository contents

- `AGENTS.md` — minimal operating protocol for agents
- `docs/AGENT_WORKFLOW.md` — lifecycle, exception notes, recovery, and review model
- `skills/agent-work-ledger/SKILL.md` — reusable operational Skill for ledger lifecycle work
- `.github/ISSUE_TEMPLATE/agent-task.yml` — lightweight task intake
- `.github/pull_request_template.md` — current-state and validation record
- `.github/workflows/agent-governance.yml` — minimal Issue-linkage / resumability checks

## Design principles

1. No meaningful work without an Issue.
2. One Issue should represent one independently reviewable deliverable.
3. The Issue defines the task; the PR owns execution state.
4. Routine progress should not require comments or duplicated status updates.
5. Comments preserve useful communication or history but never become a second current-state store.
6. Preserve useful decisions and evidence; do not dump hidden chain-of-thought or raw model reasoning.
7. Keep workspace-wide invariants in `AGENTS.md`; package reusable lifecycle behavior in the Skill; recover live state from GitHub rather than caching it elsewhere.

## Bootstrap

This repository's first workflow implementation is tracked in Issue #1 and PR #2.
