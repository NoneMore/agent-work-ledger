# GitHub-native Agent Workflow

This repository uses GitHub Issues and Pull Requests as a durable work ledger without turning routine execution into paperwork.

This document is the detailed human/reference description of the workflow. Agents should not load it on the normal execution path: `AGENTS.md` carries workspace-wide invariants, while `skills/agent-work-ledger/SKILL.md` routes to one small lifecycle reference. Consult this document when changing the workflow, resolving policy ambiguity, or when a repository-specific detail is not covered by those smaller surfaces.

## 1. System of record

Each GitHub surface has one primary responsibility:

| Surface | Role |
| --- | --- |
| Issue | Defines the work: objective, acceptance criteria, context, constraints |
| Draft / open PR | Current execution snapshot and implementation artifact |
| Issue / PR comments | Exception-only communication and history |
| Commits / checks | Implementation and validation evidence |
| GitHub Project | Cross-task progress view |

Avoid maintaining the same status in multiple places. Once a PR exists, execution state belongs in the PR body rather than being duplicated into the Issue or comments.

## 2. Normal lifecycle

```text
Issue
  -> branch
  -> first meaningful commit
  -> Draft PR
  -> work
  -> validation
  -> Ready for Review
  -> review / fixes
  -> merge
  -> Issue closed
```

The first meaningful commit gives GitHub something to compare against the base branch before the Draft PR is opened.

For work that does not produce repository changes, keep execution state on the Issue instead of creating an artificial PR.

## 3. Issue intake

A normal executable Issue should answer four questions:

1. **Objective** — what durable outcome is required?
2. **Acceptance Criteria** — how do we know it is done?
3. **Context** — what information or references are needed to execute safely?
4. **Constraints** — what boundaries or non-goals matter?

Only Objective and Acceptance Criteria are required by the Issue Form. Context, constraints, and dependencies are optional because not every task needs them. Prefer paths, links, and durable decisions over copying large reference material into the Issue.

Once repository execution moves into a PR, do not maintain `Current State` or `Next Action` on the Issue. The Issue remains the task definition.

## 4. Execution

For repository changes:

1. Create `agent/<issue-number>-<slug>`.
2. Make the first meaningful commit.
3. Open a Draft PR and link it with `Closes #N`, `Fixes #N`, or `Resolves #N`.
4. Use the PR body as the single execution snapshot.
5. Update the PR body when execution state materially changes, not after every small step.
6. Record validation before marking the PR ready for review.

The minimum PR snapshot is:

```markdown
Closes #123

## Current State

What is done, what remains, and the exact next action if unfinished.

## Validation

Tests / checks run and their results. Note anything important not run and why.

## Notes

Optional: limitations, risks, follow-ups, material decisions, or review focus.
```

`Notes` are optional. Delete the section when it adds no value. Keep the snapshot about the work itself; do not restate repository policy or the Issue acceptance criteria unless needed to explain current state.

## 5. Comments are for exceptions

Do **not** post routine claim or progress checkpoints.

The PR body always owns current execution status. If work becomes blocked, update `Current State` there. Add a comment only when the blocker also needs notification, explanation, discussion, or durable historical context.

Other reasons to leave a comment include a material decision changing implementation direction, an important discovery invalidating earlier assumptions, or a pause where the canonical execution surface alone is insufficient for safe resumption.

Comments preserve useful history; they do not become a second current-state store.

## 6. Recovery after interruption

Recovery is progressive. The goal is to obtain the smallest current context that can safely determine the next action.

1. Read the Issue objective and acceptance criteria.
2. Read linked PR metadata/body without the full diff.
3. Read changed filenames and compact stats.
4. Select relevant files, then fetch only their patches and surrounding source as needed.
5. Read check summaries and unresolved actionable review feedback when relevant; expand failed jobs/steps or referenced code only as needed.
6. Read historical Issue/PR comments only if current state cannot explain a material decision or discrepancy.

Do not use a full PR diff, complete CI logs, or full comment history as the default recovery shortcut. Small complete diffs are acceptable when the change is demonstrably small and wholly relevant.

Repository facts win over stale prose. Correct stale canonical state during authorized write work, or report the mismatch during read-only review.

## 7. Ready for Review

Before moving a PR out of Draft:

- acceptance criteria are satisfied or incomplete items are explicit,
- `Current State` accurately represents the work,
- appropriate validation is recorded,
- an exact next action is present if work is intentionally incomplete,
- optional limitations, risks, follow-ups, or review focus are recorded only when useful.

The governance workflow checks only the minimum structural contract: Issue linkage plus `Current State` and `Validation`. It intentionally does not require routine progress logging or boilerplate handoff sections.

The versioned repository ruleset at [`.github/rulesets/main.json`](../.github/rulesets/main.json) is the enforcement counterpart for `main`: when applied in GitHub, it requires changes to go through a Pull Request and requires the `Validate Issue linkage and resumability` status check before merge. Committing the JSON does not activate repository settings by itself; an administrator must import or apply the ruleset, and the live ruleset should remain aligned with the versioned file.

## 8. Completion

For repository work, prefer closing the Issue by merging a linked PR with `Closes #N`, `Fixes #N`, or `Resolves #N`.

The merged PR should be enough for a future reader to understand what was done and how it was validated. Limitations or follow-up work should be recorded only when they actually exist.

## 9. Recommended Project configuration

The only default field is:

- `Status`: Inbox / Ready / In Progress / Blocked / Review / Done

Add other fields only when the project genuinely benefits from maintaining them, for example `Priority` or `Iteration`. Prefer stable labels such as `type:*` or `area:*` over duplicating the same classification in Project fields.

Keep Project automation conservative. The workflow should make the normal path cheap and reserve extra bookkeeping for actual needs.

## 10. Operational Skill and context loading

[`../skills/agent-work-ledger/SKILL.md`](../skills/agent-work-ledger/SKILL.md) is the reusable execution layer for compatible Agent Skills runtimes.

The separation is intentional:

- `AGENTS.md` owns workspace-wide invariants and the minimal recovery order.
- `SKILL.md` owns routing, authority boundaries, progressive retrieval, and stop/exit rules.
- `skills/agent-work-ledger/references/` contains mutually exclusive lifecycle procedures; load only the selected path unless the operation changes.
- GitHub tools / APIs provide live Issue, PR, repository, check, and review state.
- The governance Action enforces the small subset of the contract that is deterministic and machine-checkable.
- This workflow document is detailed reference material, not a routine agent prompt dependency.

The retrieval model is deliberately staged:

```text
Policy
  -> live state / metadata
  -> indexes and summaries
  -> selected evidence
  -> history only on discrepancy
```

The Skill should not cache task state, create a second policy layer, or require the user to select an internal lifecycle prompt. It routes from user intent/current artifacts first and expands context only when the selected operation requires it.
