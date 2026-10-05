# Agent Working Protocol

GitHub is the durable system of record for agent work. Preserve enough state for another agent or human to resume without duplicating routine progress across Issues, comments, and Pull Requests.

## Invariants

1. **Work starts from an Issue.** The Issue defines objective, acceptance criteria, relevant context, and constraints.
2. **One Issue should be one independently reviewable deliverable.** Split larger work when that improves review or ownership.
3. **Repository changes use `Issue -> branch -> first meaningful commit -> Draft PR`.** Link the PR with `Closes #N`, `Fixes #N`, or `Resolves #N`.
4. **The PR body owns repository execution state.** Keep `Current State` and `Validation` accurate when state materially changes. `Notes` are optional.
5. **Comments are exceptions, not checkpoints.** Use them only for useful notification/history such as blockers needing attention, material decisions, important discoveries, or pause context that does not fit the PR body.
6. **Repository facts override stale prose.** Correct stale canonical state during authorized write work; report mismatches during read-only review.
7. **Do not persist hidden chain-of-thought.** Persist only conclusions, evidence, decisions, constraints, blockers, validation, and next actions that are useful to future work.

For intentionally non-repository work with no PR, the Issue is both task definition and execution record.

## Minimum PR contract

A repository-changing PR must contain:

- an Issue closing link,
- `Current State`: what is done, what remains, and the exact next action if unfinished,
- `Validation`: checks actually run and results, including important checks not run.

Before stopping or handing off unfinished work, make sure the canonical execution surface is sufficient to resume without prior chat.

## Recovery order

Recover only what the current operation needs:

1. Issue objective and acceptance criteria.
2. Linked PR metadata/body when a PR exists.
3. Relevant repository evidence: changed filenames first, then selected patches/source as needed.
4. Relevant check summaries and unresolved review feedback.
5. Historical Issue/PR comments only when current state cannot explain a material decision or discrepancy.

Do not fetch a full PR diff, complete CI logs, or full comment history by default. Expand context only after the smaller summary/index shows it is needed.

## Operational Skill

[`skills/agent-work-ledger/SKILL.md`](./skills/agent-work-ledger/SKILL.md) is intentionally user-invoked. Do not activate it from repository context or topic similarity alone. When the user explicitly invokes `agent-work-ledger`, use it to route to the smallest lifecycle procedure needed for the request.

This file remains the authoritative workspace policy; the Skill is not a second policy or state store.

Do not read [`docs/AGENT_WORKFLOW.md`](./docs/AGENT_WORKFLOW.md) on the normal execution path. Consult it when changing this workflow, resolving policy ambiguity, or when a repository-specific detail is not covered here.

If native Skill loading is unavailable but the user explicitly invokes the Skill, read `skills/agent-work-ledger/SKILL.md` directly and follow its references.
