# Continue or resume

Use for active work with a canonical execution surface. If PR feedback is the active work, use `feedback`. If intent is only to prepare/evaluate leaving Draft, do not infer authority for unrelated implementation.

1. Verify the recorded next action against the task definition and smallest relevant evidence. Reconcile selected Issue-comment input using the canonical ownership rules in `AGENTS.md`; switch to `blocker-handoff` if it creates a blocker or handoff.
2. Adopt an existing PR as its execution surface; when authorized, normalize the minimum PR contract instead of replacing the PR.
3. Promote standalone work to Issue-backed tracking when it gains an independent lifecycle and promotion is authorized; otherwise make that the blocker/next action.
4. Execute the smallest next action, replacing superseded `Current State` and recording only validation actually performed.
5. On completion or Draft exit, apply the `Ready for Review` rule in `AGENTS.md`; if transition authority is absent, leave it as the exact next action.
6. Switch paths when blocked/handed off, feedback becomes active work, or user/policy requires review.

## Done when

The requested increment is complete and durable state matches evidence, or the next required lifecycle path/authorized transition is explicit.
