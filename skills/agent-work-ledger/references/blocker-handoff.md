# Blocker or handoff

Use this path when work cannot continue normally or must be left for another executor.

## Blocker

Verify the blocker before recording it.

- PR-backed work: update PR `Current State` with the blocker, supporting evidence, unblock condition, remaining useful work, validation impact, and exact next action.
- Issue-only non-repository work: record the same information on the Issue.
- Pre-PR Issue-backed repository work: do not turn the Issue into a second execution snapshot; comment only when another person must act or useful history would otherwise be lost.
- Pre-PR standalone maintenance: do not create an Issue solely to record the blocker. Preserve useful state in the eventual PR when possible, or report the blocker directly if no durable execution surface exists yet.

Continue independent useful work when appropriate; otherwise stop at the blocker boundary.

## Handoff

Build the handoff from durable evidence, not chat history. Normalize the canonical execution surface with:

- completed work,
- remaining work,
- blockers or constraints,
- current validation state,
- material decisions needed to continue safely,
- the exact next action.

Use comments only for necessary notification or historical context that does not fit the canonical current-state surface.

## Done when

The blocker/unblock condition is explicit, or a new executor can resume safely without prior chat.
