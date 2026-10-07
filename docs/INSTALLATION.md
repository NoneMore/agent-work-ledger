# Installation

Agent Work Ledger is repository policy and Agent Skill content, not a package-manager dependency. Installation copies selected product artifacts into a target repository; it does not copy this repository's own development configuration.

## Profiles

Run from a checkout of this repository:

```bash
./install/install.sh --profile core --target /path/to/repository
```

Available profiles:

- `core` installs the reusable workspace policy as `AGENTS.md` and the Skill as `.agents/skills/agent-work-ledger/`.
- `github` installs `core` plus the Issue template, PR template, governance Action, and versioned ruleset configuration.
- `skill-only` installs only `.agents/skills/agent-work-ledger/`.

The installer refuses to overwrite an existing target `AGENTS.md`. When a repository already has workspace instructions, merge `core/AGENTS.md` manually instead of replacing local rules.

## Source and deployed paths

| Purpose | Product source | Target path |
| --- | --- | --- |
| Workspace policy | `core/AGENTS.md` | `AGENTS.md` |
| Agent Skill | `skills/agent-work-ledger/` | `.agents/skills/agent-work-ledger/` |
| Issue template | `integrations/github/ISSUE_TEMPLATE/agent-task.yml` | `.github/ISSUE_TEMPLATE/agent-task.yml` |
| PR template | `integrations/github/pull_request_template.md` | `.github/pull_request_template.md` |
| Governance Action | `integrations/github/workflows/agent-governance.yml` | `.github/workflows/agent-governance.yml` |
| Main ruleset source | `integrations/github/rulesets/main.json` | `.github/rulesets/main.json` |

Root `AGENTS.md` and root `.github/` are intentionally excluded from these mappings because they govern development of Agent Work Ledger itself.

## Ruleset activation

The ruleset JSON is a deployable configuration source, not self-applying infrastructure. Repository administrators must apply/import the installed `.github/rulesets/main.json` separately in GitHub repository settings or through the GitHub API/CLI.
