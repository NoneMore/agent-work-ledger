# Agent Work Ledger development instructions

This file governs changes to the Agent Work Ledger source repository. The reusable workflow itself lives in `skills/agent-work-ledger/` and is deployed as an explicitly invoked Agent Skill; do not copy product workflow policy into consumer workspace instructions.

## Source boundaries

- `skills/agent-work-ledger/`: reusable Agent Skill and authoritative workflow policy.
- `integrations/github/`: deployable GitHub templates, governance workflow, and ruleset source.
- `install/`: deployment mappings.
- root `.github/`: development/dogfood configuration, not deployment source.
- `docs/`: product, installation, and development references.

## Change rules

Change reusable workflow policy in `skills/agent-work-ledger/` and deployable GitHub assets in `integrations/github/`. Update root `.github/` separately only when this repository should dogfood the same change, keep installer/docs aligned with source-path changes, and preserve public workflow semantics unless tracked work explicitly changes them.
