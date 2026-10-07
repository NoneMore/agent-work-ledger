# Agent Working Protocol

GitHub is the durable system of record for agent work. Preserve enough state for another agent or human to resume without duplicating routine progress across Issues, comments, and Pull Requests.

## Invariants

1. **Use Issues for work worth tracking independently.** Problems, requests, user-visible outcomes, work needing discussion/coordination, and multi-PR efforts normally deserve an Issue. The decisive test is whether the work needs a lifecycle independent of the current PR; category examples are guidance, not exemptions.
2. **One Issue should be one independently reviewable deliverable.** Split larger work when that improves review or ownership.
3. **All repository changes use `branch -> first meaningful commit -> Draft PR`.** Issue-backed work normally starts on `agent/<issue-number>-<slug>` and links the PR with `Closes #N`, `Fixes #N`, or `Resolves #N`. Standalone maintenance normally starts on `agent/maintenance-<slug>` and declares `Standalone maintenance: <brief reason or scope>` in the PR body. Branch naming is a creation convention, not the canonical tracking source.
4. **The PR body owns repository execution state.** Keep `Current State` and `Validation` accurate when state materially changes. `Notes` are optional.
5. **Comments are exceptions, not checkpoints.** Use them only for useful notification/history such as blockers needing attention, material decisions, important discoveries, or pause context that does not fit the PR body.
6. **Repository facts override stale prose.** Correct stale canonical state during authorized write work; report mismatches during read-only review.
7. **Do not persist hidden chain-of-thought.** Persist only conclusions, evidence, decisions, constraints, blockers, validation, and next actions that are useful to future work.

Standalone maintenance is a tracking choice, not a low-risk classification. Dependency updates, CI/build/release changes, refactors, tests, documentation, developer tooling, and repository metadata may use the PR-only path when the PR itself is the complete public work item; normal review, validation, security, and ownership rules still apply.

If standalone maintenance develops independent tracking value, promote it to Issue-backed work: create an Issue, replace the standalone declaration in `## Tracking` with an Issue closing link, and continue from the existing PR. Do not rename an existing branch solely to reflect that promotion; the PR tracking declaration and linked Issue are canonical.

For intentionally non-repository work with an Issue and no PR, the Issue is both task definition and execution record.

## Minimum PR contract

A repository-changing PR must contain:

- `## Tracking`: either an Issue closing link or `Standalone maintenance: <brief reason or scope>`,
- `Current State`: what is done, what remains, and the exact next action if unfinished,
- `Validation`: checks actually run and results, including important checks not run.

Before stopping or handing off unfinished work, make sure the canonical execution surface is sufficient to resume without prior chat.

## Recovery order

Recover only what the current operation needs:

1. Determine the tracking source from `## Tracking`: linked Issue objective and acceptance criteria when one exists; otherwise the standalone-maintenance declaration plus PR title/scope.
2. Linked PR metadata/body when a PR exists.
3. Relevant repository evidence: changed filenames first, then selected patches/source as needed.
4. Relevant check summaries and unresolved review feedback.
5. Historical Issue/PR comments only when current state cannot explain a material decision or discrepancy.

Do not fetch a full PR diff, complete CI logs, or full comment history by default. Expand context only after the smaller summary/index shows it is needed.
