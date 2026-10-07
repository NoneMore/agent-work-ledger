# Agent Work Ledger development instructions

For this source repository, `core/AGENTS.md` is the authoritative Issue/PR lifecycle and recovery policy. Read it for workflow actions, use `skills/agent-work-ledger/` when explicitly invoked, and keep durable execution state in GitHub rather than this file.

## Source boundaries

- `core/AGENTS.md`: reusable workspace policy installed as `AGENTS.md`.
- `skills/agent-work-ledger/`: reusable Agent Skill.
- `integrations/github/`: deployable GitHub templates, governance workflow, and ruleset source.
- `install/`: deployment mappings.
- root `.github/`: development/dogfood configuration, not deployment source.
- `docs/`: product, installation, and development references.

## Change rules

Change reusable workflow policy in `core/AGENTS.md` and deployable GitHub assets in `integrations/github/`. Update root `.github/` separately only when this repository should dogfood the same change, keep installer/docs aligned with source-path changes, and preserve public workflow semantics unless tracked work explicitly changes them.
