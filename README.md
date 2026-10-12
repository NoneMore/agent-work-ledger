# agent-work-ledger

A lightweight GitHub-native durable work ledger and workflow-state controller for human + agent collaboration.

Agent Work Ledger keeps problem/task definition, repository execution state, decisions, validation evidence, blockers, feedback state, reconciliation state, and next actions durable in GitHub so another human or agent can resume without prior chat history.

It owns **where work state lives, what that state currently is, and which workflow obligations remain**. It recovers authoritative GitHub state, reconciles stale snapshots, and applies authorized lifecycle/state mutations. It does not perform the substantive project work needed to satisfy those obligations, select who should perform it, or treat an intended handoff as progress.

## What this repository contains

The repository separates product sources from the configuration used to develop Agent Work Ledger itself:

- [`skills/agent-work-ledger/`](./skills/agent-work-ledger/) — reusable, explicitly invoked Agent Skill and authoritative workflow-state policy.
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

For a full GitHub installation, the installer can also create or update the repository ruleset through authenticated GitHub CLI instead of requiring a separate settings step:

```bash
./install/install.sh \
  --profile github \
  --target /path/to/repository \
  --apply-ruleset
```

Use `--repo OWNER/REPO` when the target path cannot be used to infer the GitHub repository. Ruleset writes require repository Administration write permission.

## Responsibility boundary

Agent Work Ledger owns **durable workflow state**, not substantive project outcomes or orchestration.

It owns:

- work identity and tracking mode;
- Issue/PR/initiative lifecycle and canonical state placement;
- recovery after interruption and reconciliation of stale state with GitHub facts;
- blockers, outstanding obligations, and exact next actions;
- validation evidence and explicit required-validation state;
- feedback, contract-reconciliation, and handoff state;
- authorized GitHub lifecycle/state mutations.

It does not:

- choose product, domain, architecture, or interface direction;
- invent or materially reinterpret requirements;
- decide substantive decomposition boundaries;
- implement production changes;
- choose validation strategy beyond explicit task/repository requirements;
- perform substantive technical review or correctness judgments;
- select, invoke, dispatch, or coordinate the person, agent, Skill, or capability that should produce a missing substantive outcome.

When authoritative evidence already establishes a new workflow fact, the ledger may persist that fact. When advancing state would require missing substantive work or judgment, it leaves the unmet outcome and exact next action explicit and stops. If ownership, authority, or the next substantive choice is unclear, the ledger asks the user rather than guessing.

## Core workflow

- **Issues define independently tracked work** — either executable deliverables with a stable objective and acceptance criteria, or exploratory initiatives whose problem/decision lifecycle must remain durable while direction and decomposition evolve.
- **Pull Requests track repository execution and reconciliation** — current state, validation evidence, and contract-reconciliation status for every repository change, including standalone maintenance that needs no separate Issue.
- **Comments and reviews carry durable input and feedback** — use Issue comments for discussion/input around Issue-defined work and PR comments/reviews for PR feedback; do not make them a second current-state store.
- **GitHub Projects show portfolio progress** without becoming a second source of execution truth.

Executable repository changes normally follow:

```text
Issue-backed: Issue -> branch -> first meaningful commit -> Draft PR -> work / validation -> [Ready when authorized] -> [review / feedback when required] -> merge
PR-only:      branch -> first meaningful commit -> Draft PR -> work / validation -> [Ready when authorized] -> [review / feedback when required] -> merge
```

The ledger observes and updates the durable state around this lifecycle; it does not perform the `work / validation` step. A substantive change, review result, decision, or validation result becomes ledger state only after authoritative evidence for that result exists.

Exploratory initiatives preserve current understanding, evidence, open questions, candidate versus accepted directions, child relationships, remaining parent-level acceptance, and the next established shaping obligation. The ledger records those facts; it does not investigate, design, specify, decompose, or decide acceptance merely because one of those outcomes is missing.

The PR body is the canonical execution snapshot. `## Tracking` chooses exactly one mode: one or more Issue closing links, or `Standalone maintenance: <brief reason or scope>`. `Current State`, `Validation`, and `Contract Reconciliation` stay accurate as material state changes. Reconciliation records whether durable contract work is pending, reconciled, has no designated contract source, or does not exist; a pending reconciliation is unfinished and not Ready. `Ready for Review` is a PR state transition handled from active work, not a lifecycle route. Review is optional unless repository policy or explicit user intent requires it, and PR feedback may arrive before or without formal review.

See [`docs/AGENT_WORKFLOW.md`](./docs/AGENT_WORKFLOW.md) for the detailed lifecycle and state boundary.

## Operational Skill

[`skills/agent-work-ledger/SKILL.md`](./skills/agent-work-ledger/SKILL.md) packages the reusable workflow-state protocol as an explicitly user-invoked Agent Skill. Its frontmatter disables model invocation for runtimes that support those fields; OpenAI/Codex invocation policy is declared in [`skills/agent-work-ledger/agents/openai.yaml`](./skills/agent-work-ledger/agents/openai.yaml).

Once invoked, the Skill applies shared workflow policy, selects the matching state operation under [`skills/agent-work-ledger/references/`](./skills/agent-work-ledger/references/), and recovers live GitHub state progressively. These operations establish or reconcile tracking, execution snapshots, initiative state, blockers/handoffs, review state, and feedback state. They do not select or invoke external project capabilities.

## GitHub integration

Deployable GitHub configuration lives under [`integrations/github/`](./integrations/github/):

- `ISSUE_TEMPLATE/agent-task.yml` — executable-task intake with required objective and acceptance criteria plus optional durable `Contract Impact` delta; when the user or established project policy has already designated a contract source, the Issue may name it.
- `ISSUE_TEMPLATE/initiative.yml` — exploratory-initiative intake with only the durable problem/opportunity required; evidence, questions, directions, related work, next shaping step, and authority constraints may evolve over time.
- `pull_request_template.md` — tracking, current-state, validation, and contract-reconciliation record.
- `workflows/agent-governance.yml` — deterministic tracking/resumability checks, including structural presence of contract reconciliation.
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

1. Use Issues for problems, requests, initiatives, and work worth tracking independently; do not manufacture them for routine maintenance.
2. Executable Issues should represent independently reviewable deliverables; exploratory initiatives may span decisions and multiple executable child Issues while retaining parent-level acceptance.
3. Do not mechanically infer semantic readiness or turn candidate directions into implementation requirements before they are explicitly accepted.
4. Every repository change goes through a PR; Issue linkage is conditional, not universal.
5. The PR owns repository execution state; exploratory initiative state remains on the parent Issue; contract sources designated by the user or established project policy own current durable product/architecture contract truth.
6. The ledger owns durable workflow state and authorized state transitions; substantive work and executor selection remain outside it.
7. Never advance state merely because work was intended, delegated, or discussed; require authoritative evidence for the new state.
8. Routine progress should not require comments or duplicated status updates.
9. Preserve useful conclusions, evidence, decisions, constraints, blockers, validation, feedback disposition, and next actions; do not persist hidden chain-of-thought.
10. Keep deployable product sources separate from repository-development configuration.

## Bootstrap

The first workflow implementation is tracked in Issue #1 and PR #2.
