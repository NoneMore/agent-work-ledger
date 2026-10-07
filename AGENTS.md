# Agent Work Ledger development instructions

This file governs work on the Agent Work Ledger source repository. The deployable workspace policy is maintained separately at [`core/AGENTS.md`](./core/AGENTS.md).

## Workflow

1. Read `core/AGENTS.md` before starting, resuming, handing off, preparing, or reviewing repository-changing work. Its Issue/PR lifecycle and recovery rules are authoritative for this repository too.
2. Use the explicitly invoked Agent Skill under `skills/agent-work-ledger/` when the runtime supports it.
3. Keep GitHub as the durable execution record. Do not use this development file as a second task-state store.

## Source boundaries

- `core/AGENTS.md` is the reusable workspace policy installed into consumer repositories as `AGENTS.md`.
- `skills/agent-work-ledger/` is the reusable Agent Skill package.
- `integrations/github/` is the deployable GitHub integration source: Issue/PR templates, governance workflow, and ruleset configuration.
- `install/` maps those source artifacts into a target repository.
- root `.github/` configures development of Agent Work Ledger itself. It may dogfood the same behavior, but it is not the deployment source.
- `docs/` documents the product, installation, and development model.

## Change rules

- Change reusable workflow policy in `core/AGENTS.md`, not in this file.
- Change deployable GitHub assets under `integrations/github/`; update root `.github/` separately only when this repository should dogfood the same change.
- Keep installer mappings and installation documentation aligned with source-path changes.
- Preserve the public workflow semantics unless the tracked work explicitly changes them.
