# Installation

Agent Work Ledger is an explicitly invoked Agent Skill with an optional GitHub integration, not a package-manager dependency. Installation copies selected product artifacts into a target repository; it does not copy this repository's own development configuration or create consumer workspace instructions.

## Profiles

Run from a checkout of this repository:

```bash
./install/install.sh --profile core --target /path/to/repository
```

Available profiles:

- `core` installs `.agents/skills/agent-work-ledger/`.
- `github` installs `core` plus the executable-task and exploratory-initiative Issue Forms, PR template, governance Action, and versioned ruleset configuration.
- `skill-only` is a compatibility alias for `core` and also installs only `.agents/skills/agent-work-ledger/`.

The installer does not create, overwrite, or merge a target `AGENTS.md`. Agent Work Ledger workflow policy lives in the Skill package and enters agent context through explicit Skill invocation.

## Source and deployed paths

| Purpose | Product source | Target path |
| --- | --- | --- |
| Agent Skill and workflow policy | `skills/agent-work-ledger/` | `.agents/skills/agent-work-ledger/` |
| Executable task Issue Form | `integrations/github/ISSUE_TEMPLATE/agent-task.yml` | `.github/ISSUE_TEMPLATE/agent-task.yml` |
| Exploratory initiative Issue Form | `integrations/github/ISSUE_TEMPLATE/initiative.yml` | `.github/ISSUE_TEMPLATE/initiative.yml` |
| PR template | `integrations/github/pull_request_template.md` | `.github/pull_request_template.md` |
| Governance Action | `integrations/github/workflows/agent-governance.yml` | `.github/workflows/agent-governance.yml` |
| Main ruleset source | `integrations/github/rulesets/main.json` | `.github/rulesets/main.json` |

Root `AGENTS.md` and root `.github/` are intentionally excluded from these mappings because they govern development of Agent Work Ledger itself.

## Apply the GitHub ruleset

The `github` profile can activate the repository ruleset directly through GitHub CLI instead of requiring a separate manual settings step:

```bash
./install/install.sh \
  --profile github \
  --target /path/to/repository \
  --apply-ruleset
```

When `--apply-ruleset` is used, the installer:

1. verifies that `gh` is installed and authenticated,
2. infers `OWNER/REPO` from the target checkout,
3. looks for the `Main branch` repository ruleset,
4. updates the existing ruleset with `PUT` or creates it with `POST`, and
5. sends `integrations/github/rulesets/main.json` directly as the REST API request body.

If the target path is not a GitHub checkout, specify the repository explicitly:

```bash
./install/install.sh \
  --profile github \
  --target /path/to/repository \
  --apply-ruleset \
  --repo OWNER/REPO
```

Repository-ruleset writes require credentials with repository Administration write permission. The operation is idempotent by ruleset name: rerunning it updates the existing `Main branch` ruleset rather than intentionally creating another one.

Omit `--apply-ruleset` when you only want the versioned ruleset file copied into the repository. The installed `.github/rulesets/main.json` remains useful as an auditable local copy of the desired GitHub configuration.
