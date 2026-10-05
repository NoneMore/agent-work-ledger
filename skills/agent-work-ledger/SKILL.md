---
name: agent-work-ledger
description: Operate GitHub work that follows the Agent Work Ledger protocol: start or resume Issue/PR work, handle blockers or handoffs, prepare Draft PRs for Ready for Review, or review PRs. Use when repository policy makes Issues the task definition, PRs the execution record for repository work, and GitHub artifacts the durable source of truth.
---

# Agent Work Ledger

Use the repository's durable GitHub state instead of prior chat history.

Read and follow the applicable `AGENTS.md` first. Repository policy is authoritative; this Skill only routes and operationalizes that policy. Consult workflow documentation when the selected path needs repository-specific detail.

## Contract

For each request:

1. infer the lifecycle operation from the user's intent and current Issue/PR shape,
2. recover only the live state needed for that operation,
3. act within the user's authority and repository policy,
4. update only the canonical execution surface when state materially changes,
5. stop at an observable outcome or explicit blocker.

Repository facts override stale prose. Persist conclusions, evidence, decisions, blockers, validation, and next actions—not private chain-of-thought.

Canonical surfaces:

- **Issue** — task definition; also execution state only for intentionally Issue-only non-repository work.
- **PR body** — current execution state and validation once repository-changing work has a PR.
- **Diff / commits / checks** — implementation and validation evidence.
- **Comments** — exception communication or history, never a routine second status store.

## Authority

- Implementation, execution, continue, and resume requests permit work-item changes and updates to its canonical execution surface, subject to repository policy and runtime permissions.
- Blocker and handoff requests permit the state updates needed to leave work recoverable.
- Preparing a Draft PR for review permits validation and PR-body normalization. Moving Draft → Ready requires explicit user intent or clear repository delegation.
- Review is read-only unless fixes are separately requested.
- Merge, close, or other finalizing actions require explicit user intent or clear repository delegation.

Prompt text is not an authorization boundary; runtime and tool permissions remain authoritative.

## Route first, then recover

Choose the smallest matching path before broad investigation.

| Path | Minimum state to recover |
| --- | --- |
| Start repository work | Issue objective/acceptance criteria, applicable policy, relevant repository evidence |
| Continue/resume PR work | Issue criteria, PR current state, then only relevant diff/checks/review feedback |
| Issue-only non-repository work | Issue objective, criteria, current execution state, linked deliverables when relevant |
| Blocker or handoff | Canonical current state plus evidence needed to verify the blocker or next action |
| Prepare for Ready | Issue criteria, final diff, relevant validation/checks, repository readiness policy |
| Review PR | Issue criteria, diff/surrounding code, relevant validation; PR prose and history only as needed |

Read historical Issue/PR comments only when current state cannot explain a material decision or discrepancy.

If prose conflicts with repository facts, trust the facts. Correct stale state only during an authorized write-capable operation; during review, report the mismatch instead.

## Lifecycle paths

### Start work

Use for an executable Issue that has not entered its normal execution surface.

For repository-changing work, follow the repository's branch/first-change/Draft-PR convention, link the Issue, and initialize accurate current state and validation. If the user asked for full implementation, continue into **Continue or resume** rather than stopping at setup.

For intentionally non-repository work with no PR, execute against the Issue and keep its execution state current.

**Done when:** the correct execution surface exists and is accurate, or full requested work has moved into continuation.

### Continue or resume

Verify the recorded next action against durable evidence, derive the smallest concrete next action when stale, and continue without repeating completed investigation unless verification is needed.

Update the canonical execution surface only when state materially changes. Keep validation claims current and explicit about important checks not run.

**Done when:** the requested scope/increment is complete and durable state matches evidence, or another path becomes necessary.

### Handle a blocker

Verify the blocker before recording it.

- PR-backed work: update PR current state with the blocker, evidence, unblock condition, remaining useful work, validation impact, and exact next action.
- Issue-only non-repository work: record the same information on the Issue.
- Pre-PR repository work: do not turn the Issue into a second execution snapshot; comment only when another person must act or history would otherwise be lost.

Continue independent useful work when appropriate; otherwise stop at the blocker boundary.

**Done when:** the blocker is accurately represented on the correct surface and the unblock condition/next action is explicit.

### Prepare a handoff

Inspect durable evidence rather than summarizing chat. Normalize the canonical execution surface with completed work, remaining work, blockers/constraints, validation state, material decisions needed to continue safely, and the exact next action.

Use comments only for necessary notification or history.

**Done when:** a new executor can resume safely without prior chat.

### Prepare for Ready for Review

Re-check Issue acceptance criteria, final diff, and appropriate validation. Remove stale remaining-work text and record material limitations or incomplete items explicitly.

Apply the repository's authoritative Ready-for-Review policy; do not invent a stricter gate. Move Draft → Ready only when authority permits it.

**Done when:** the PR satisfies repository readiness policy and its state/validation are accurate; if transition authority is absent, it remains correctly prepared in Draft.

Never claim validation that was not performed.

### Review a Pull Request

Treat review as read-only unless fixes are separately authorized.

Ground review in the Issue, diff/surrounding code, and relevant validation. Use PR state text and history to explain discrepancies, not as stronger evidence than repository facts.

Report only actionable findings: identify the concrete location/artifact, observable concern, and minimum correction. Avoid speculative refactors unrelated to the Issue.

**Done when:** findings or approval are evidence-based and remaining validation limits are explicit.

## Stop conditions

Stop or switch paths rather than improvising when required Issue context is absent, requirements remain materially ambiguous, required permissions/dependencies/approvals are unavailable, repository readiness policy blocks transition, a read-only request would require mutation, or a finalizing action lacks authority.

For recoverable stops, leave the canonical surface accurate enough to state what is blocked and what happens next.

## Exit check

Before finishing a write-capable operation, verify only what that path should have changed:

- the canonical execution surface matches durable evidence,
- validation claims are supported by checks or evidence actually obtained,
- comments remain exception-only,
- the next executor or reviewer can determine the next action without prior chat.

Prefer deterministic repository or CI enforcement for machine-checkable guarantees.
