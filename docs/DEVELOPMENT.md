# Developing Agent Work Ledger

This repository deliberately separates reusable product artifacts from the configuration used to develop the product itself.

## Ownership boundaries

| Area | Owns | Deployable? |
| --- | --- | --- |
| `skills/agent-work-ledger/` | reusable Agent Skill package and workflow policy | yes |
| `integrations/github/` | reusable GitHub platform integration | yes |
| `install/` | deployment mapping/tooling | no; it performs deployment |
| `docs/` | product/development reference | no |
| root `AGENTS.md` | instructions for changing this repository | no |
| root `.github/` | live GitHub configuration for this repository | no |

Root `.github/` may dogfood behavior also shipped from `integrations/github/`, but the integration directory is the deployment source of truth. Update both only when Agent Work Ledger itself should adopt the same change.

## Product changes

- Workflow-policy, routing, or lifecycle action changes belong in `skills/agent-work-ledger/` and should be reflected in `docs/AGENT_WORKFLOW.md` when human/reference behavior changes.
- GitHub template, governance, or ruleset changes intended for consumers belong in `integrations/github/`.
- Source-path changes must update `install/install.sh` and `docs/INSTALLATION.md` in the same PR.

## Repository-development changes

Changes that affect only this repository's CI, PR template, Issue intake, or other maintenance automation belong under root `.github/`. They are not installed into consumer repositories unless the corresponding product integration is changed separately.

## Validation

For deployment-structure changes, validate at least:

1. `install/install.sh --profile skill-only` installs only the Skill.
2. `--profile core` installs only the Skill and does not create or modify consumer `AGENTS.md`.
3. `--profile github` additionally installs files from `integrations/github/` without creating or modifying consumer `AGENTS.md`.
4. documentation contains no stale deployment-source paths or claims that Agent Work Ledger requires consumer workspace instructions.
