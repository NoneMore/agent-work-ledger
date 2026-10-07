# agent-work-ledger

A lightweight GitHub-native work ledger for human + agent collaboration.

Agent Work Ledger keeps task definition, repository execution state, and validation durable in GitHub so another human or agent can resume without prior chat history.

## What this repository contains

The repository separates product sources from the configuration used to develop Agent Work Ledger itself:

- [`core/AGENTS.md`](./core/AGENTS.md) — reusable workspace policy installed into consumer repositories as `AGENTS.md`.
- [`skills/agent-work-ledger/`](./skills/agent-work-ledger/) — reusable, explicitly invoked Agent Skill.
- [`integrations/github/`](./integrations/github/) — deployable GitHub Issue/PR templates, governance Action, and ruleset source.
- [`install/`](./install/) — profile-based deployment tooling.
- [`docs/`](./docs/) — workflow, installation, and development references.
- root [`AGENTS.md`](./AGENTS.md) and [`.github/`](./.github/) — development configuration for this repository itself, not deployment sources.

See [`docs/DEVELOPMENT.md`](./docs/DEVELOPMENT.md) for the source/deployment boundary and [`docs/INSTALLATION.md`](./docs/INSTALLATION.md) for installation details.

## Install

From a checkout of this repository:

```bash
./install/install.sh --profile core --target /path/to/repository
```

Profiles:

- `core` installs the reusable workspace policy and Agent Skill.
- `github` installs `core` plus the GitHub integration.
- `skill-only` installs only the Agent Skill.

The installer refuses to overwrite an existing target `AGENTS.md`; merge workspace instructions manually when the target already has one.

For a full GitHub installation, the installer can also create or update the repository ruleset through authenticated GitHub CLI instead of requiring a separate settings step:

```bash
./install/install.sh \
  --profile github \
  --target /path/to/repository \
  --apply-ruleset
```

Use `--repo OWNER/REPO` when the target path cannot be used to infer the GitHub repository. Ruleset writes require repository Administration write permission.

## Core workflow

- **Issues define independently tracked work** — problems, requests, objectives, acceptance criteria, context, and constraints when the work deserves its own public work item.
- **Pull Requests track repository execution** — current state and validation for every repository change, including standalone maintenance that needs no separate Issue.
- **Comments are exceptions** — use them for blockers, material decisions, important discoveries, or pause context rather than routine checkpoints.
- **GitHub Projects show portfolio progress** without becoming a second source of execution truth.

For repository changes, the normal path is:

```text
Issue-backed: Issue -> branch -> first meaningful commit -> Draft PR -> work -> validation -> Ready for Review
PR-only:      branch -> first meaningful commit -> Draft PR -> work -> validation -> Ready for Review
```

The PR body is the canonical execution snapshot. `## Tracking` chooses exactly one mode: one or more Issue closing links, or `Standalone maintenance: <brief reason or scope>`. `Current State` and `Validation` stay accurate as material state changes.

See [`docs/AGENT_WORKFLOW.md`](./docs/AGENT_WORKFLOW.md) for the detailed lifecycle.

## Operational Skill

[`skills/agent-work-ledger/SKILL.md`](./skills/agent-work-ledger/SKILL.md) packages reusable execution behavior as an explicitly user-invoked Agent Skill. Its frontmatter disables model invocation for runtimes that support those fields; OpenAI/Codex invocation policy is declared in [`skills/agent-work-ledger/agents/openai.yaml`](./skills/agent-work-ledger/agents/openai.yaml).

Once invoked, the Skill infers the lifecycle operation and loads only the matching file under [`skills/agent-work-ledger/references/`](./skills/agent-work-ledger/references/). Live GitHub state is recovered progressively rather than preloading full diffs, complete CI logs, or entire comment histories.

## GitHub integration

Deployable GitHub configuration lives under [`integrations/github/`](./integrations/github/):

- `ISSUE_TEMPLATE/agent-task.yml` — lightweight intake for independently tracked work.
- `pull_request_template.md` — tracking, current-state, and validation record.
- `workflows/agent-governance.yml` — deterministic tracking/resumability checks.
- `rulesets/main.json` — REST-compatible main-branch enforcement configuration.

The versioned ruleset requires PR-based changes and the `Validate Issue linkage and resumability` status check when applied. `install/install.sh --profile github --apply-ruleset` applies it through `gh api`, creating the `Main branch` ruleset when absent and updating it when present. Without that flag, the JSON remains a reproducible, auditable configuration source that can be applied later.

The root `.github/` directory configures this repository's own development. It can intentionally dogfood the integration, but installers must source deployable files from `integrations/github/`.

## Recommended GitHub Project setup

Start with one field only:

| Field | Suggested values |
| --- | --- |
| Status | Inbox, Ready, In Progress, Blocked, Review, Done |

Add `Priority`, `Iteration`, or other fields only when the project genuinely benefits from maintaining them. Prefer stable labels such as `type:*` or `area:*` over duplicate classifications.

## Design principles

1. Use Issues for problems, requests, and work worth tracking independently; do not manufacture them for routine maintenance.
2. One Issue should represent one independently reviewable deliverable when an Issue is used.
3. Every repository change goes through a PR; Issue linkage is conditional, not universal.
4. The PR owns repository execution state.
5. Routine progress should not require comments or duplicated status updates.
6. Preserve useful conclusions, evidence, decisions, constraints, blockers, validation, and next actions; do not persist hidden chain-of-thought.
7. Keep deployable product sources separate from repository-development configuration.

## Bootstrap

The first workflow implementation is tracked in Issue #1 and PR #2.
