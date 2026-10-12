# agent-work-ledger

A lightweight GitHub-native durable work ledger for human + agent collaboration.

Agent Work Ledger keeps task/initiative state, repository execution snapshots, validation evidence, blockers, feedback consequences, contract-reconciliation state, and next actions durable in GitHub so another human or agent can resume without prior chat history.

It is a **state reconciler, not a project-work orchestrator**: it establishes/adopts durable tracking, reconciles canonical state with authoritative evidence, and applies authorized GitHub state transitions. It does not perform the substantive design, implementation, review, or other project work represented by that state.

## What this repository contains

- [`skills/agent-work-ledger/`](./skills/agent-work-ledger/) — reusable, explicitly invoked Agent Skill and workflow-state policy.
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

- `core` installs the Agent Skill.
- `github` installs `core` plus the GitHub integration.
- `skill-only` is a compatibility alias that also installs only the Agent Skill.

Agent Work Ledger does not install or modify consumer `AGENTS.md` files. Its workflow policy enters agent context through explicit Skill invocation rather than an always-loaded workspace policy.

For a full GitHub installation, the installer can also create or update the repository ruleset through authenticated GitHub CLI:

```bash
./install/install.sh \
  --profile github \
  --target /path/to/repository \
  --apply-ruleset
```

Use `--repo OWNER/REPO` when the target path cannot be used to infer the GitHub repository. Ruleset writes require repository Administration write permission.

## State model

Each durable surface has one primary job:

- **Issue** — independently tracked task/initiative definition and Issue-only state.
- **PR body** — repository-execution snapshot once a PR exists.
- **Issue/PR comments and reviews** — durable discussion and feedback.
- **Commits/checks** — implementation and validation evidence.
- **Designated contract source** — current product/architecture contract truth.
- **GitHub Project** — portfolio view, not another execution-state store.

State follows authoritative evidence, not intent. Planned, requested, delegated, or expected work is not progress by itself. Unknowns may stay explicit; the ledger asks the user only when the requested ledger mutation itself requires a user decision or authority.

Repository-changing work normally follows:

```text
Issue-backed: Issue -> branch -> first meaningful commit -> Draft PR -> work/validation -> [Ready] -> [review/feedback] -> merge
PR-only:      branch -> first meaningful commit -> Draft PR -> work/validation -> [Ready] -> [review/feedback] -> merge
```

The ledger manages the durable state around that lifecycle. It does not manufacture the substantive `work/validation/review` outcomes.

## Operational Skill

[`skills/agent-work-ledger/SKILL.md`](./skills/agent-work-ledger/SKILL.md) has only two ledger operations:

- **establish** — create/adopt the durable tracking/execution surface;
- **reconcile** — reconcile all existing state, including initiative state, execution, validation, contract state, review/feedback, blockers/handoff, readiness, and completion.

This keeps evidence domains from becoming separate workflow state machines.

The PR body is the canonical repository-execution snapshot:

- `## Tracking`
- `## Current State`
- `## Validation`
- `## Contract Reconciliation`

Contract reconciliation uses evidence-based states. `No reconciliation indicated.` means current authoritative task/project state does not establish a reconciliation obligation; it is not a claim that the ledger independently proved a negative.

See [`docs/AGENT_WORKFLOW.md`](./docs/AGENT_WORKFLOW.md) for the detailed lifecycle.

## GitHub integration

Deployable GitHub configuration lives under [`integrations/github/`](./integrations/github/):

- `ISSUE_TEMPLATE/agent-task.yml` — executable-task intake.
- `ISSUE_TEMPLATE/initiative.yml` — exploratory-initiative intake.
- `pull_request_template.md` — tracking, current-state, validation, and contract-reconciliation record.
- `workflows/agent-governance.yml` — deterministic tracking/resumability checks.
- `rulesets/main.json` — REST-compatible main-branch enforcement configuration.

The governance workflow intentionally checks only deterministic structure. It does not decide semantic readiness, technical correctness, acceptance, or validation sufficiency.

The root `.github/` directory configures this repository's own development. It can dogfood the integration, but installers source deployable files from `integrations/github/`.

## Recommended GitHub Project setup

Start with one field:

| Field | Suggested values |
| --- | --- |
| Status | Inbox, Ready, In Progress, Blocked, Review, Done |

Add fields only when they create real portfolio value. Do not duplicate canonical Issue/PR state into Project fields.

## Design principles

1. One canonical surface per responsibility.
2. Track independently only when durable tracking has value.
3. State follows evidence, not intent/delegation.
4. Unknown is valid state; user escalation is not the default.
5. Repository changes use PRs; Issue linkage is conditional.
6. The ledger reconciles state but does not orchestrate substantive work.
7. Recovery is progressive and evidence-driven.
8. Keep deterministic governance separate from semantic judgment.
9. Preserve resumable conclusions/state, not routine progress logs or chain-of-thought.
10. Keep deployable product sources separate from repository-development configuration.

## Bootstrap

The first workflow implementation is tracked in Issue #1 and PR #2.
