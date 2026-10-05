# GitHub-native Agent Workflow

This repository uses GitHub Issues and Pull Requests as a durable work ledger without turning routine execution into paperwork.

## 1. System of record

Each GitHub surface has one primary responsibility:

| Surface | Role |
| --- | --- |
| Issue | Defines the work: objective, acceptance criteria, context, constraints |
| Draft / open PR | Current execution snapshot and implementation artifact |
| Issue / PR comments | Exceptions: blockers, material decisions, important discoveries, pause notes |
| Commits / checks | Implementation and validation evidence |
| GitHub Project | Cross-task progress view |

Avoid maintaining the same status in multiple places. Once a PR exists, execution state belongs in the PR body rather than being duplicated into the Issue.

## 2. Normal lifecycle

```text
Issue
  -> branch + Draft PR
  -> work
  -> validation + handoff
  -> Ready for Review
  -> review / fixes
  -> merge
  -> Issue closed
```

For work that does not produce repository changes, keep execution state on the Issue instead of creating an artificial PR.

## 3. Issue intake

A normal executable Issue should answer four questions:

1. **Objective** — what durable outcome is required?
2. **Acceptance Criteria** — how do we know it is done?
3. **Context** — what information or references are needed to execute safely?
4. **Constraints** — what boundaries or non-goals matter?

Do not require the author or agent to maintain `Current State` or `Next Action` on the Issue after execution starts. That information moves to the PR for repository-changing work.

## 4. Execution

For repository changes:

1. Create `agent/<issue-number>-<slug>`.
2. Open a Draft PR early and link it with `Closes #N`, `Fixes #N`, or `Resolves #N`.
3. Use the PR body as the single execution snapshot.
4. Update the PR body when execution state materially changes, not after every small step.
5. Complete validation and handoff before marking the PR ready for review.

The PR snapshot should contain:

```markdown
## Goal

What this PR delivers.

## Current State

What is done, what remains, and the next action if unfinished.

## Validation

Tests / checks run and their results. Note anything not run and why.

## Handoff

Known limitations, follow-ups, risks, and review focus.
```

## 5. Comments are for exceptions

Do **not** post routine claim or progress checkpoints.

Write an Issue or PR comment when one of these happens:

- work is blocked on human or external input,
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

This keeps history available without forcing every execution step into GitHub prose.

## 6. Recovery after interruption

A replacement agent should recover in this order:

1. Issue: objective and acceptance criteria.
2. Linked PR body: current execution state.
3. Current diff / changed files.
4. CI and unresolved review comments when relevant.
5. Historical Issue / PR comments only if the current state is insufficient or a decision needs context.

Repository facts win over stale prose. Correct the PR body or leave a concise note when there is a meaningful mismatch.

## 7. Review handoff

Before moving a PR out of Draft:

- acceptance criteria are satisfied or incomplete items are explicit,
- appropriate validation is recorded,
- known limitations and follow-ups are explicit,
- unfinished work has an exact next action,
- the reviewer knows where independent attention is most valuable.

The governance workflow checks only a small structural contract: Issue linkage plus `Goal`, `Validation`, and `Handoff` sections. It intentionally does not require routine progress logging.

## 8. Completion

For repository work, prefer closing the Issue by merging a linked PR with `Closes #N`, `Fixes #N`, or `Resolves #N`.

The merged PR should be enough for a future reader to understand:

- what changed,
- how it was validated,
- what limitations remain,
- what follow-up work exists.

## 9. Recommended Project configuration

Suggested fields:

- `Status`: Inbox / Ready / In Progress / Blocked / Review / Done
- `Priority`: P0 / P1 / P2 / P3
- `Workstream`: product area / discipline
- `Risk`: low / medium / high
- `Iteration`: sprint / cycle

Suggested automations:

- New Issue -> `Inbox`
- Ready task -> `Ready`
- Active work -> `In Progress`
- PR ready for review -> `Review`
- Linked Issue closed / PR merged -> `Done`

Keep Project automation conservative. The workflow should make the normal path cheap and reserve extra bookkeeping for exceptions.
