# Continue or resume

Use this path for active work with a canonical execution surface. Apply the recovery budget from `AGENTS.md`. If PR feedback is the active work, use `feedback` instead.

1. Verify the recorded next action still advances the current task definition and matches the smallest relevant repository evidence. For Issue-backed work, account for relevant current Issue comments that materially change scope, constraints, decisions, or blockers; when authorized, reflect the resulting durable task/execution state on the Issue rather than leaving canonical meaning split across comments.
2. Treat authorship as irrelevant to routing. If work arrives as an existing PR, adopt that PR as the execution surface; when authorized, normalize `## Tracking`, `Current State`, and `Validation` instead of creating a replacement PR.
3. If standalone work now needs an independent lifecycle, promote it when authorized; otherwise record that promotion as the blocker or next action.
4. Continue from the smallest concrete next action.
5. Replace superseded `Current State` rather than appending progress history, and record only validation actually performed.
6. When repository work is complete or should leave Draft, account for tracking mode, intended scope, acceptance criteria for every closing-linked Issue, current state, validation, and any material unresolved feedback. If the PR is Draft and those conditions are satisfied, move it to Ready for Review only with explicit user intent or clear repository delegation; otherwise leave that transition as the exact next action.
7. Switch lifecycle paths if the work becomes blocked, is being handed off, PR feedback becomes the active work, or the user/policy requires review.

## Done when

The requested increment is complete and durable state matches evidence, another lifecycle path is required, or the PR is correctly prepared for its next authorized transition.
