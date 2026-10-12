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

Run the release-hardening suite before release-oriented changes:

```bash
./tests/release-checks.sh
```

The suite requires `shellcheck`, Python 3, and PyYAML. CI installs those dependencies and runs the suite on pull requests and pushes to `main`.

It covers:

1. installer profiles, preservation of consumer `AGENTS.md`, legacy-policy warnings, and GitHub artifact installation;
2. mocked GitHub CLI ruleset repository inference plus create/update behavior;
3. valid and invalid PR-body fixtures against the deployable governance workflow's actual validation script;
4. byte-for-byte parity between deployable GitHub integration files and this repository's dogfood copies;
5. documentation source-boundary assertions for the removed consumer `AGENTS.md` policy path;
6. shell syntax and ShellCheck plus JSON/YAML syntax parsing.

For deployment-structure changes, also confirm the resulting installed artifact set matches the intended profile semantics; the installer fixtures exercise the standard `core`, `skill-only`, and `github` paths automatically.

## Releases

Use [`RELEASING.md`](./RELEASING.md) for the public-release checklist, repository settings that must be confirmed before announcement, and the tagged-release procedure.
