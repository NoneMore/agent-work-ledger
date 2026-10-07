# Installation

Agent Work Ledger is repository policy and Agent Skill content, not a package-manager dependency. Installation copies the selected workflow artifacts into a target repository.

## Profiles

Run from a checkout of this repository:

```bash
./install/install.sh --profile core --target /path/to/repository
```

Available profiles:

- `core` installs the workspace policy as `AGENTS.md` and the Skill as `.agents/skills/agent-work-ledger/`.
- `github` installs `core` plus the Issue template, PR template, governance Action, and versioned ruleset configuration.
- `skill-only` installs only `.agents/skills/agent-work-ledger/`.

The installer refuses to overwrite an existing target `AGENTS.md`. When a repository already has workspace instructions, merge the Agent Work Ledger policy manually instead of replacing local rules.

## Source and deployed paths

The current source layout is transitional while deployable artifacts are being separated from this repository's own development configuration.

| Purpose | Source path | Target path |
| --- | --- | --- |
| Workspace policy | `AGENTS.md` | `AGENTS.md` |
| Agent Skill | `skills/agent-work-ledger/` | `.agents/skills/agent-work-ledger/` |
| Issue template | `.github/ISSUE_TEMPLATE/agent-task.yml` | `.github/ISSUE_TEMPLATE/agent-task.yml` |
| PR template | `.github/pull_request_template.md` | `.github/pull_request_template.md` |
| Governance Action | `.github/workflows/agent-governance.yml` | `.github/workflows/agent-governance.yml` |
| Main ruleset source | `.github/rulesets/main.json` | `.github/rulesets/main.json` |

The ruleset JSON is a deployable configuration source, not self-applying infrastructure. Repository administrators must apply/import the ruleset separately.
