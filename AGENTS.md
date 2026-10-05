# Agent Working Protocol

GitHub is the durable system of record for agent work. Keep the workflow lightweight: record enough state for another agent or human to resume, but do not duplicate routine progress across Issues, comments, and PRs.

## Core rules

1. **Work starts from an Issue.** The Issue defines the objective, acceptance criteria, context, and constraints.
2. **One Issue should be one independently reviewable deliverable.** Split larger work when that improves review or ownership.
3. **Open a Draft PR early for repository changes.** Link it with `Closes #N`, `Fixes #N`, or `Resolves #N`. The PR body is the single execution snapshot for in-progress work.
4. **Do not write routine checkpoints.** Add an Issue or PR comment only for a material decision, blocker, important discovery, or when work must pause across sessions and the PR body alone is not enough to resume safely.
5. **Before stopping or handing off, make the PR resumable.** Its body must say what is done, what remains, validation status, known risks, and the exact next action when relevant.

Do not store hidden chain-of-thought. Persist conclusions, evidence, decisions, constraints, blockers, and next actions only when they are useful to future work.

## Task shape

A normal task should contain:

- **Objective** — the durable outcome.
- **Acceptance Criteria** — observable completion conditions.
- **Context** — only the information or references needed to execute safely.
- **Constraints** — important boundaries or non-goals.

Do not maintain a second execution-status copy in the Issue once a PR exists. The Issue describes the work; the PR describes execution.

## Branch and PR convention

Preferred branch format:

```text
agent/<issue-number>-<short-slug>
```

Normal lifecycle:

```text
Issue
  -> branch + Draft PR
  -> work (keep PR body current when state materially changes)
  -> validation + handoff
  -> Ready for Review
  -> review / fixes
  -> merge
  -> Issue closed
```

For non-repository work where no PR exists, use the Issue as both task definition and execution record.

## When to comment

Comments are an exception path, not a routine progress log. Write one when:

- a blocker requires outside input,
- a material decision changes implementation direction or public behavior,
- an important discovery invalidates earlier assumptions,
- work pauses and another executor could not safely resume from the PR body alone.

Keep the comment concise:

```markdown
## Agent Note

### State
What changed or what is blocked.

### Decision / Evidence
Only if relevant.

### Next
The exact resume action or required input.
```

## PR execution snapshot

Keep the PR body useful to both a reviewer and a replacement agent. It should contain:

- **Goal** — what this PR delivers.
- **Current State** — what is done, what remains, and the next action if unfinished.
- **Validation** — checks run and results; explicitly note anything not run.
- **Handoff** — limitations, follow-ups, risks, and review focus.

Update it when execution state materially changes; do not rewrite it after every small step.

## Recovery

When resuming work:

1. Read the Issue for objective and acceptance criteria.
2. Read the linked PR body and current diff.
3. Check CI and unresolved review comments if relevant.
4. Read historical Issue / PR comments only when the current state is insufficient or a decision needs its history.

Repository facts override stale prose. If there is a meaningful mismatch, correct the PR body or leave a concise note.

## Definition of Done

An Issue is done when:

- acceptance criteria are met,
- the deliverable is merged or otherwise durably linked,
- appropriate validation is recorded,
- important limitations or follow-up work are explicit,
- the PR or Issue leaves enough state for future readers to understand what happened.
