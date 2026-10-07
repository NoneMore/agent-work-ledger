# agent-work-ledger

A lightweight GitHub-native work ledger for human + agent collaboration.

The core model is simple:

- **Issues define independently tracked work** — problems, requests, objectives, acceptance criteria, context, and constraints when the work deserves its own public work item.
- **Pull Requests track repository execution** — current state and validation for every repository change, including standalone maintenance that needs no separate Issue.
- **Comments are exceptions** — communication or history for blockers, material decisions, important discoveries, or pause notes.
- **GitHub Projects show portfolio progress** — without becoming a second source of execution truth.

The workflow is designed so a new agent can resume work without access to previous chat history, while keeping routine process and context overhead low.

## Start here

1. Read [`AGENTS.md`](./AGENTS.md).
2. Decide whether the work needs an Issue. Use one for problems, requests, user-visible outcomes, discussion/coordination, multi-PR efforts, or anything worth tracking independently. Do not create one only to parent routine repository maintenance.
3. For repository changes, create either `agent/<issue-number>-<slug>` for Issue-backed work or `agent/maintenance-<slug>` for standalone maintenance, then make the first meaningful commit.
4. Open a **Draft PR**. Link Issue-backed work with one or more closing links such as `Closes #<issue>`; for PR-only work declare `Standalone maintenance: <brief reason or scope>`. Treat the PR body as the single in-progress execution snapshot.
5. Keep `Current State` and `Validation` accurate when state materially changes.
6. Do not post routine progress checkpoints; comment only when useful communication or history is needed.
7. Before Ready for Review, ensure the PR is resumable and validation is recorded.

See [`docs/AGENT_WORKFLOW.md`](./docs/AGENT_WORKFLOW.md) for the detailed human/reference lifecycle. Agents do not need to load that document during normal execution.

## Operational Skill

[`skills/agent-work-ledger/SKILL.md`](./skills/agent-work-ledger/SKILL.md) packages reusable execution behavior as an explicitly user-invoked Agent Skill. Its frontmatter disables model invocation for runtimes that support those fields; OpenAI/Codex invocation policy is declared separately in [`skills/agent-work-ledger/agents/openai.yaml`](./skills/agent-work-ledger/agents/openai.yaml).

`AGENTS.md` remains the authoritative workspace policy. The Skill stays small: once invoked, it infers the lifecycle operation, applies authority/retrieval rules, and loads only the matching file under [`skills/agent-work-ledger/references/`](./skills/agent-work-ledger/references/) rather than carrying every lifecycle procedure in context.

Live GitHub state is recovered progressively: PR metadata/body first, then changed filenames and selected patches/source; check summaries and unresolved review feedback precede detailed logs/history. Full diffs, complete CI logs, and full comment history are not normal recovery inputs.

The Skill uses the open Agent Skills packaging shape (`<skill-name>/SKILL.md`) while runtime-specific invocation controls remain metadata rather than workflow instructions.

## Recommended GitHub Project setup

Start with one field only:

| Field | Suggested values |
| --- | --- |
| Status | Inbox, Ready, In Progress, Blocked, Review, Done |

Add fields such as `Priority` or `Iteration` only when the project genuinely benefits from maintaining them. Prefer stable labels such as `type:*` and `area:*` over duplicating the same classification in Project fields.

## Repository contents

- `AGENTS.md` — always-relevant workspace invariants and minimal recovery order
- `docs/AGENT_WORKFLOW.md` — detailed lifecycle/reference documentation
- `skills/agent-work-ledger/SKILL.md` — small operational router and progressive retrieval contract
- `skills/agent-work-ledger/references/` — lifecycle procedures loaded only for the selected path
- `skills/agent-work-ledger/agents/openai.yaml` — OpenAI/Codex invocation policy
- `.github/ISSUE_TEMPLATE/agent-task.yml` — lightweight intake for independently tracked work
- `.github/pull_request_template.md` — tracking, current-state, and validation record
- `.github/workflows/agent-governance.yml` — minimal tracking / resumability checks
- `.github/rulesets/main.json` — importable main-branch enforcement configuration

## Repository enforcement

[`.github/rulesets/main.json`](./.github/rulesets/main.json) is the versioned ruleset configuration for `main`. It requires changes to go through a Pull Request and requires the existing `Validate Issue linkage and resumability` status check before merge. Despite the historical check name, the governance workflow accepts either one or more Issue closing links or an explicit standalone-maintenance declaration, while continuing to require `Current State` and `Validation`.

The file is a reproducible configuration source, not self-applying infrastructure. An administrator must import or apply it in GitHub repository settings or through the GitHub API/CLI. Keep the live repository ruleset aligned with the versioned JSON when enforcement policy changes.

## Design principles

1. Use Issues for problems, requests, and work worth tracking independently; do not manufacture them for routine maintenance.
2. One Issue should represent one independently reviewable deliverable when an Issue is used.
3. Every repository change goes through a PR; Issue linkage is conditional, not universal.
4. The PR owns repository execution state.
5. Routine progress should not require comments or duplicated status updates.
6. Comments preserve useful communication or history but never become a second current-state store.
7. Preserve useful decisions and evidence; do not dump hidden chain-of-thought or raw model reasoning.
8. Keep workspace-wide invariants in `AGENTS.md`; package reusable routing in the Skill; load one lifecycle path at a time; recover live state from GitHub progressively rather than caching or preloading it.

## Bootstrap

The first workflow implementation is tracked in Issue #1 and PR #2.
