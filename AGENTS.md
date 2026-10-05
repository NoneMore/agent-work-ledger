# Agent Working Protocol

GitHub is the durable system of record for agent work. Keep the workflow lightweight: preserve enough state for another agent or human to resume, without duplicating routine progress across Issues, comments, and Pull Requests.

## Core rules

1. **Work starts from an Issue.** The Issue defines the objective, acceptance criteria, context, and constraints.
2. **One Issue should be one independently reviewable deliverable.** Split larger work when that improves review or ownership.
3. **For repository changes, create a branch and make the first meaningful commit before opening a Draft PR.** Link the PR with `Closes #N`, `Fixes #N`, or `Resolves #N`.
4. **The PR body owns current execution state.** Keep `Current State` and `Validation` accurate when state materially changes. Optional notes may record risks, follow-ups, decisions, or review focus.
5. **Do not write routine checkpoints.** Comments are only for useful communication or history: blockers that need attention, material decisions, important discoveries, or pause notes that do not fit cleanly in the PR body. Comments never become a second current-state record.

Before stopping or handing off unfinished repository work, make sure the PR body says what is done, what remains, and the exact next action.

Do not store hidden chain-of-thought. Persist conclusions, evidence, decisions, constraints, blockers, and next actions only when they are useful to future work.

## Task shape

A normal Issue should contain:

- **Objective** — the durable outcome.
- **Acceptance Criteria** — observable completion conditions.
- **Context** — only the information or references needed to execute safely.
- **Constraints** — important boundaries or non-goals.

Once a PR exists, do not maintain a second copy of execution status in the Issue. The Issue defines the work; the PR describes execution.

## Branch and PR convention

Preferred branch format:

```text
agent/<issue-number>-<short-slug>
```

Normal lifecycle:

```text
Issue
  -> branch
  -> first meaningful commit
  -> Draft PR
  -> work (update PR body when state materially changes)
  -> validation
  -> Ready for Review
  -> review / fixes
  -> merge
  -> Issue closed
```

For non-repository work where no PR exists, use the Issue as both task definition and execution record.

## Operational prompt pack

The files in [`prompts/`](./prompts/) are reusable entry points for common lifecycle transitions: start, routine work, blocked work, handoff, resume, Ready for Review, and review.

They are helpers, not a second policy layer. This file remains authoritative. Use the prompt that matches the current transition and replace its bracketed Issue or PR identifier before execution.

## PR execution snapshot

The minimum PR contract is:

- **Issue link** — a closing keyword such as `Closes #123`.
- **Current State** — what is done, what remains, and the exact next action if unfinished.
- **Validation** — checks run and results; explicitly note anything not run.

`Notes` are optional and may contain limitations, risks, follow-ups, material decisions, or review focus. Do not add boilerplate when there is nothing useful to say.

## When to comment

Comments are an exception path, not a routine progress log.

If a blocker changes the current execution state, update the PR body. Add a comment only when the blocker also needs notification, rationale, discussion, or historical preservation.

Other good reasons to comment:

- a material decision changes implementation direction or public behavior,
- an important discovery invalidates earlier assumptions,
- work pauses and another executor could not safely resume from the PR body alone.

A concise note is enough:

```markdown
## Agent Note

### State
What changed or what is blocked.

### Decision / Evidence
Only if relevant.

### Next
The exact resume action or required input.
```

## Recovery

When resuming repository work:

1. Read the Issue for objective and acceptance criteria.
2. Read the linked PR body and current diff.
3. Check CI and unresolved review comments when relevant.
4. Read historical Issue / PR comments only when current state is insufficient or a decision needs context.

Repository facts override stale prose. If there is a meaningful mismatch, correct the PR body or leave a concise explanatory note.

## Definition of Done

An Issue is done when:

- acceptance criteria are met,
- the deliverable is merged or otherwise durably linked,
- appropriate validation is recorded,
- important limitations or follow-up work are explicit when they exist,
- the PR or Issue leaves enough state for future readers to understand what happened.
