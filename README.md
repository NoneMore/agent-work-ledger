# agent-work-ledger

A lightweight GitHub-native work control plane and durable work ledger for human + agent collaboration.

Agent Work Ledger keeps problem/task definition, repository execution state, decisions, validation evidence, blockers, feedback state, and next actions durable in GitHub so another human or agent can resume without prior chat history.

It coordinates **what work is active, where it is in its lifecycle, what obligation comes next, and where that state lives**. Substantive project work — such as choosing product or architecture direction, decomposing deliverables, implementing production behavior, selecting validation strategy, or performing technical review — belongs to the executor or project capability that owns that outcome. The ledger may determine that such an outcome is required next, provide durable context for it, and persist its result.

## What this repository contains

The repository separates product sources from the configuration used to develop Agent Work Ledger itself:

- [`skills/agent-work-ledger/`](./skills/agent-work-ledger/) — reusable, explicitly invoked Agent Skill and authoritative workflow/control-plane policy.
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

Agent Work Ledger owns **work control**, not every kind of work content.

It owns:

- work identity and tracking mode;
- Issue/PR/initiative lifecycle and canonical state placement;
- recovery after interruption;
- current obligations, blockers, and workflow-level next actions;
- routing substantive work to an appropriate executor or capability;
- durable progress, decision, validation, feedback, reconciliation, and handoff state;
- authority constraints around GitHub mutations and finalizing transitions.

It does not independently own:

- product, domain, architecture, or interface decisions;
- invention or material reinterpretation of requirements;
- substantive decomposition boundaries;
- production implementation;
- validation-strategy selection beyond explicit task/repository requirements;
- substantive technical review or correctness judgments.

This is intentionally not a passive activity log. The ledger may determine, for example, that the next obligation is to obtain a design decision, implement a remaining acceptance criterion, evaluate a review concern, or reconcile a designated contract source. It then coordinates that work and records the outcome rather than absorbing the specialist responsibility itself.

## Core workflow

- **Issues define independently tracked work** — either executable deliverables with a stable objective and acceptance criteria, or exploratory initiatives whose problem/decision lifecycle must remain durable while direction and decomposition evolve.
- **Pull Requests track repository execution and reconciliation** — current state, validation evidence, and contract-reconciliation status for every repository change, including standalone maintenance that needs no separate Issue.
- **Comments and reviews carry durable input and feedback** — use Issue comments for discussion/input around Issue-defined work and PR comments/reviews for PR feedback; do not make them a second current-state store.
- **GitHub Projects show portfolio progress** without becoming a second source of execution truth.

Executable repository changes follow the normal path:

```text
Issue-backed: Issue -> branch -> first meaningful commit -> Draft PR -> work / validation -> [Ready when authorized] -> [review / feedback when required] -> merge
PR-only:      branch -> first meaningful commit -> Draft PR -> work / validation -> [Ready when authorized] -> [review / feedback when required] -> merge
```

In this model, `work / validation` is coordinated by the ledger but substantively performed by the executor or capability that owns the requested outcome. The ledger recovers the current obligation, routes it, and then updates the canonical snapshot from the returned result.

Exploratory initiatives preserve current understanding, evidence, open questions, candidate versus accepted directions, and the next uncertainty-reducing or decision step. Commitment is an explicit semantic decision rather than a mechanically inferred readiness test. The ledger owns that durable shaping state and may route investigation, design, specification, decomposition, or acceptance evaluation to the appropriate substantive executor. An initiative may decompose into executable child Issues and remain open as the parent product/problem acceptance surface.

The PR body is the canonical execution snapshot. `## Tracking` chooses exactly one mode: one or more Issue closing links, or `Standalone maintenance: <brief reason or scope>`. `Current State`, `Validation`, and `Contract Reconciliation` stay accurate as material state changes. Reconciliation records whether durable contract work is pending, reconciled, has no designated contract source, or does not exist; a pending reconciliation is unfinished and not Ready. `Ready for Review` is a PR state transition handled from active work, not a lifecycle route. Review is optional unless repository policy or explicit user intent requires it, and PR feedback may arrive before or without formal review.

See [`docs/AGENT_WORKFLOW.md`](./docs/AGENT_WORKFLOW.md) for the detailed lifecycle and responsibility boundary.

## Operational Skill

[`skills/agent-work-ledger/SKILL.md`](./skills/agent-work-ledger/SKILL.md) packages the reusable control-plane workflow as an explicitly user-invoked Agent Skill. Its frontmatter disables model invocation for runtimes that support those fields; OpenAI/Codex invocation policy is declared in [`skills/agent-work-ledger/agents/openai.yaml`](./skills/agent-work-ledger/agents/openai.yaml).

Once invoked, the Skill applies shared workflow policy, infers the lifecycle operation, and loads only the matching file under [`skills/agent-work-ledger/references/`](./skills/agent-work-ledger/references/). Those routes coordinate shaping, start/resume, review, feedback, blockers, and handoff. When a route requires a substantive design, specification, decomposition, implementation, investigation, validation, or review outcome, it delegates or routes that work to the appropriate executor and persists the result. Live GitHub state is recovered progressively rather than preloading full diffs, complete CI logs, or entire comment histories.

The Skill intentionally does not depend on a particular external project-skill suite. Any executor that owns the required substantive outcome may be used.

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
6. The ledger owns coordination and durable workflow state; substantive project outcomes remain owned by the executor or capability responsible for them.
7. Routine progress should not require comments or duplicated status updates.
8. Preserve useful conclusions, evidence, decisions, constraints, blockers, validation, feedback disposition, and next actions; do not persist hidden chain-of-thought.
9. Keep deployable product sources separate from repository-development configuration.

## Bootstrap

The first workflow implementation is tracked in Issue #1 and PR #2.
