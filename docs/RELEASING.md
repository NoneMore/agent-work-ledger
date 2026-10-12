# Releasing Agent Work Ledger

Agent Work Ledger uses Git tags and GitHub Releases as the immutable public release boundary. `main` is the development branch. Pre-1.0 releases are preview releases and may change workflow semantics between minor versions.

## Public-release prerequisites

Before announcing a release, confirm all of the following:

1. A repository `LICENSE` file exists and reflects the license selected by the repository owner.
2. The repository is public and has a concise description and useful topics.
3. `main` is protected by an active repository ruleset that requires pull-request based changes and the `Validate Issue linkage and resumability` status check. For this repository, also require the `Release checks` status check before merging release-oriented changes.
4. There are no known release-blocking Issues or Pull Requests.
5. The intended release commit has successful `Agent Governance` and `Release Checks` runs.

The versioned consumer ruleset in `integrations/github/rulesets/main.json` intentionally contains only product-level governance requirements. Repository-specific release enforcement belongs in this repository's GitHub settings rather than the deployable integration.

## Prepare the release

Use a PR for release-oriented repository changes. Before merge, run:

```bash
./tests/release-checks.sh
```

The CI `Release Checks` workflow runs on pull requests, pushes to `main`, version tags matching `v*`, and manual dispatches.

After the release-preparation PR is merged:

1. Confirm the exact `main` commit to release.
2. Confirm `Agent Governance` and `Release Checks` succeeded for that commit.
3. Create a version tag such as `v0.1.0` on that exact commit.
4. Confirm the tag-triggered `Release Checks` run succeeds.
5. Create the GitHub Release from that tag.
6. Announce the release only after the release page, license, repository visibility, and installation instructions are all correct.

Do not move an already published release tag. If a released version needs correction, make a new patch release.

## Release notes

Keep release notes short and user-facing. For the initial `v0.1.0` release, cover:

- what Agent Work Ledger is and is not;
- the `core` and `github` installation profiles;
- the `establish` and `reconcile` operations;
- the optional GitHub Issue/PR templates, governance Action, and repository ruleset;
- the pre-1.0 compatibility expectation;
- a link to `docs/INSTALLATION.md`.

For later releases, additionally call out behavior changes, migration steps, and known limitations when applicable.
