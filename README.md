# agent-work-ledger

A lightweight GitHub-native durable work ledger for human + agent collaboration.

Agent Work Ledger is a **state reconciler, not a project-work orchestrator**. It establishes or adopts durable tracking, reconciles canonical GitHub state with authoritative evidence, and applies authorized lifecycle/state mutations without performing the substantive work represented by that state.

## Release status

Agent Work Ledger is currently **pre-1.0**. The initial public release line is `v0.1.x`: workflow semantics may still evolve between minor pre-1.0 releases.

For reproducible use, install from a tagged release rather than a moving `main` checkout. `main` remains the development branch. See [`docs/RELEASING.md`](./docs/RELEASING.md) for the repository release procedure.

## Repository layout

- [`skills/agent-work-ledger/`](./skills/agent-work-ledger/) — reusable, explicitly invoked Agent Skill and normative workflow-state policy.
- [`integrations/github/`](./integrations/github/) — deployable GitHub Issue/PR templates, governance Action, and ruleset source.
- [`install/`](./install/) — profile-based deployment tooling.
- [`docs/`](./docs/) — workflow, installation, and development references.
- root [`AGENTS.md`](./AGENTS.md) and [`.github/`](./.github/) — configuration for developing this repository, not deployment sources.

See [`docs/DEVELOPMENT.md`](./docs/DEVELOPMENT.md) for the source/deployment boundary and [`docs/INSTALLATION.md`](./docs/INSTALLATION.md) for installation details.

## Install

Run the installer from a checkout of the release you want to deploy:

```bash
./install/install.sh --profile core --target /path/to/repository
```

Profiles:

- `core` installs the Agent Skill.
- `github` installs `core` plus the GitHub integration.
- `skill-only` is a compatibility alias for `core`.

Agent Work Ledger does not install or modify consumer `AGENTS.md` files. For a full GitHub installation, authenticated GitHub CLI can also apply the repository ruleset:

```bash
./install/install.sh \
  --profile github \
  --target /path/to/repository \
  --apply-ruleset
```

Use `--repo OWNER/REPO` when the target path cannot identify the repository. Ruleset writes require repository Administration write permission.

## Workflow model

Each durable fact has one owner: Issues hold independently tracked task/initiative state, PR bodies hold repository-execution snapshots, native comments/reviews hold discussion and feedback, commits/checks provide implementation/validation evidence, and any designated contract source owns current product/architecture contract truth.

Repository-changing work normally follows:

```text
Issue-backed: Issue -> branch -> first meaningful commit -> Draft PR -> work/validation -> [Ready] -> [review/feedback] -> merge
PR-only:      branch -> first meaningful commit -> Draft PR -> work/validation -> [Ready] -> [review/feedback] -> merge
```

The ledger manages the durable state around that lifecycle. Planned, requested, delegated, or expected work is not progress by itself; unknowns may remain explicit rather than forcing user escalation.

The Skill intentionally exposes only two ledger operations:

- **establish** — create or adopt the durable tracking/execution surface;
- **reconcile** — align all existing workflow state with authoritative evidence.

See [`skills/agent-work-ledger/SKILL.md`](./skills/agent-work-ledger/SKILL.md) for the normative protocol and [`docs/AGENT_WORKFLOW.md`](./docs/AGENT_WORKFLOW.md) for the human-oriented rationale.

## GitHub integration

Deployable GitHub configuration lives under [`integrations/github/`](./integrations/github/):

- `ISSUE_TEMPLATE/agent-task.yml` — executable-task intake;
- `ISSUE_TEMPLATE/initiative.yml` — exploratory-initiative intake;
- `pull_request_template.md` — canonical execution snapshot;
- `workflows/agent-governance.yml` — deterministic tracking/resumability checks;
- `rulesets/main.json` — REST-compatible main-branch enforcement configuration.

Governance intentionally checks deterministic structure only; semantic readiness, technical correctness, acceptance, and validation sufficiency remain outside automated enforcement.

The root `.github/` directory may dogfood the integration, but installers source deployable files from `integrations/github/`.

## Recommended GitHub Project setup

Start with one field: `Status = Inbox / Ready / In Progress / Blocked / Review / Done`. Add fields only when they provide real portfolio value; do not duplicate canonical Issue/PR state.

## Bootstrap

The first workflow implementation is tracked in Issue #1 and PR #2.
