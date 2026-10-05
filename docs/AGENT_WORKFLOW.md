# GitHub-native Agent Workflow

This repository uses GitHub Issues and Pull Requests as a durable work ledger without turning routine execution into paperwork.

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

Only Objective and Acceptance Criteria are required by the Issue Form. Context, constraints, and dependencies are optional because not every task needs them.

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

Tests / checks run and their results. Note anything not run and why.

## Notes

Optional: limitations, risks, follow-ups, material decisions, or review focus.
```

`Notes` are optional. Delete the section when it adds no value.

## 5. Comments are for exceptions

Do **not** post routine claim or progress checkpoints.

The PR body always owns current execution status. If work becomes blocked, update `Current State` there. Add a comment only when the blocker also needs notification, explanation, discussion, or durable historical context.

Other reasons to leave a comment:

- a material decision changes implementation direction or public behavior,
- an important discovery invalidates earlier assumptions,
- work must pause and the PR body alone is insufficient for safe resumption.

A concise note is enough:

```markdown
## Agent Note

### State
What changed or what is blocked.

### Decision / Evidence
Only if relevant.

### Next
Exact resume action or required input.
```

Comments preserve useful history; they do not become a second current-state store.

## 6. Recovery after interruption

A replacement agent should recover in this order:

1. Issue: objective and acceptance criteria.
2. Linked PR body: current execution state and validation.
3. Current diff / changed files.
4. CI and unresolved review comments when relevant.
5. Historical Issue / PR comments only if current state is insufficient or a decision needs context.

Repository facts win over stale prose. Correct the PR body or leave a concise note when there is a meaningful mismatch.

## 7. Ready for Review

Before moving a PR out of Draft:

- acceptance criteria are satisfied or incomplete items are explicit,
- `Current State` accurately represents the work,
- appropriate validation is recorded,
- an exact next action is present if work is intentionally incomplete,
- optional limitations, risks, follow-ups, or review focus are recorded only when useful.

The governance workflow checks only the minimum structural contract: Issue linkage plus `Current State` and `Validation`. It intentionally does not require routine progress logging or boilerplate handoff sections.

## 8. Completion

For repository work, prefer closing the Issue by merging a linked PR with `Closes #N`, `Fixes #N`, or `Resolves #N`.

The merged PR should be enough for a future reader to understand what was done and how it was validated. Limitations or follow-up work should be recorded only when they actually exist.

## 9. Recommended Project configuration

The only default field is:

- `Status`: Inbox / Ready / In Progress / Blocked / Review / Done

Add other fields only when the project genuinely benefits from maintaining them, for example:

- `Priority`: P0 / P1 / P2 / P3
- `Iteration`: sprint / cycle

Prefer stable labels such as `type:*` or `area:*` over duplicating the same classification in Project fields.

Suggested Status automations, when useful:

- New Issue -> `Inbox`
- Ready task -> `Ready`
- Active work -> `In Progress`
- PR ready for review -> `Review`
- Linked Issue closed / PR merged -> `Done`

Keep Project automation conservative. The workflow should make the normal path cheap and reserve extra bookkeeping for actual needs.
