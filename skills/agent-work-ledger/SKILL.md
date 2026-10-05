---
name: agent-work-ledger
description: Execute, resume, handle blockers, hand off, prepare or move Draft PRs to Ready for Review, or review GitHub work that follows the Agent Work Ledger protocol. Use when working from a GitHub Issue or Pull Request in a repository where Issues define requested outcomes, PR bodies hold current execution state for repository work, comments preserve exception history, and repository changes/checks provide evidence.
---

# Agent Work Ledger

Operate GitHub work through the repository's durable ledger instead of relying on chat history.

Read and follow the repository's applicable `AGENTS.md` first. That file owns workspace-wide policy. This Skill supplies the reusable operational procedure for moving a work item through the ledger lifecycle.

## Behavioral contract

Given a GitHub Issue or Pull Request and the user's requested operation:

1. recover the relevant durable state,
2. choose the smallest matching lifecycle path,
3. act only within that path and the user's authority,
4. keep the canonical GitHub artifacts accurate,
5. stop at an explicit, verifiable outcome.

Do not create a second execution-state store.

Keep these roles distinct:

- **Issue** — requested outcome, acceptance criteria, context, constraints; for non-repository work where no PR exists, it also holds current execution state as defined by repository policy.
- **PR body** — current execution state and validation once repository-changing work has a PR.
- **Diff / commits / checks** — implementation and validation evidence.
- **Comments** — exception-only communication or history.

Repository facts override stale prose. Persist useful conclusions, evidence, decisions, constraints, blockers, and next actions; do not persist private chain-of-thought.

## Preconditions and authority

Require one of these task contexts:

- an executable Issue to implement or execute, including non-repository work that intentionally has no PR,
- an existing PR to continue, recover, hand off, handle a blocker, or prepare for review,
- an Issue-only non-repository task to continue, recover, hand off, or handle a blocker,
- an existing PR to review.

Use live repository and GitHub state rather than cached copies when it is cheaply recoverable.

Do not invent missing requirements, permissions, credentials, approvals, or validation results.

Authority rules:

- A request to implement, execute, continue, or resume work permits changes needed for that work item and updates to its canonical execution surface, subject to repository policy and runtime permissions.
- A direct blocker or handoff request permits the ledger-state updates and exception communication needed to leave the work accurately recoverable.
- A request to prepare a Draft PR for review permits validation and PR-body updates needed to make readiness explicit. Changing the PR from Draft to Ready for Review additionally requires explicit user intent to make that transition, or clear governing repository instructions that delegate it. A general implementation request alone does not imply that collaboration-state transition.
- A review request is read-only unless the user separately asks for fixes. During read-only review, inspect stale or contradictory PR state but report it as a finding rather than mutating GitHub state.
- Do not merge, close, or perform another finalizing action unless the user explicitly requests it or governing repository instructions clearly delegate that authority.

## Recover state before acting

For an existing PR, reconstruct state in this order:

1. linked Issue objective and acceptance criteria,
2. PR `Current State`, `Validation`, and useful notes,
3. current diff, commits, and relevant repository files,
4. CI/checks and unresolved review feedback when relevant,
5. historical Issue/PR comments only when current state or a material decision needs context.

If durable prose disagrees with repository facts, trust the repository. For an authorized write-capable operation, correct the stale execution snapshot before relying on it. For a read-only review, do not mutate the PR; record the mismatch as a review finding instead.

For Issue-only non-repository work, recover the objective, acceptance criteria, and current execution state from the Issue itself, then inspect linked deliverables or other durable evidence when relevant. Read historical comments only when the current Issue state is insufficient or a material decision needs context.

For repository-changing work that has not produced a PR yet, read the Issue and relevant repository evidence before changing code. Do not treat this pre-PR state as Issue-only non-repository execution.

## Resolve the operation

Choose the operation from the user's request and current GitHub state. Do not require the user to name an internal lifecycle mode.

### Start implementation or execution

Use when an executable Issue exists and work has not yet entered its normal execution surface.

For repository-changing work:

1. Verify the Issue provides an actionable objective and acceptance criteria.
2. Inspect relevant code, tests, docs, and constraints.
3. If safe execution is blocked by material ambiguity or a dependency, use the blocked path instead of guessing.
4. Create or use `agent/<issue-number>-<short-slug>` when the repository follows the default branch convention.
5. Make the first meaningful repository change before opening a Draft PR.
6. Open a Draft PR linked with `Closes #N`, `Fixes #N`, or `Resolves #N`.
7. Initialize the PR body so `Current State` states what is done, what remains, and the exact next action; initialize `Validation` accurately.
8. If the user requested full implementation, transition immediately into **Continue or resume work** and keep working until the requested scope is complete or another lifecycle path / stop condition applies. If the user requested only initialization or starting the work, stop after the Draft PR and its snapshot are valid.

For non-repository work where repository policy says no PR is needed, keep both task definition and current execution state on the Issue and execute against that Issue record rather than creating an artificial PR.

**Complete this operation when:** either (a) requested initialization has established the correct execution surface and accurate state, or (b) a full work request has transitioned into the continuation path rather than stopping at setup.

### Continue or resume work

Use when either an implementation PR already exists or repository policy intentionally keeps non-repository execution on the Issue.

1. Recover state using the appropriate recovery order above.
2. Verify the recorded next action against durable evidence.
3. If it is stale or underspecified, derive the smallest concrete next action from acceptance criteria and evidence, then update the canonical execution surface: PR body for PR-backed work, Issue for Issue-only non-repository work.
4. Continue execution without repeating already completed investigation unless verification is necessary.
5. When execution state materially changes, update the canonical execution surface rather than posting a routine progress comment.
6. Keep validation evidence current on that execution surface; state important checks or validation not performed and why.

The current execution state should make clear:

- what is complete,
- what remains,
- any blocker,
- the exact next action while unfinished.

**Complete this operation when:** the requested scope or increment is finished and the canonical execution state again matches durable evidence, or another lifecycle path becomes necessary.

### Handle a blocker

Use when required progress cannot continue because of missing input, permission, dependency, unresolved constraint, or another concrete external condition.

1. Verify the blocker against available repository state, linked evidence, configuration, and Issue constraints.
2. If a PR exists, update PR `Current State` with what cannot proceed, the concrete reason, concise evidence, the unblock condition, useful independent work, and the exact next action. Update `Validation` when the blocker prevents a check from running.
3. If no PR exists because this is intentionally Issue-only non-repository work, update the Issue execution record with the same current blocker, unblock condition, remaining work, validation limitation when relevant, and exact next action.
4. If no PR exists yet for repository-changing work, do not create an artificial PR and do not turn the Issue body into a second execution snapshot. Add a concise Issue comment only when another person must act, notification/discussion is needed, or important blocker history would otherwise be lost; otherwise report the blocker to the user and stop safely.
5. For PR-backed or Issue-only non-repository work, add a comment only when another person must act, notification/discussion is needed, or important historical rationale would otherwise be lost.
6. Continue independent useful work when appropriate; otherwise stop at the blocker boundary.

**Complete this operation when:** the blocker is accurately represented at the canonical surface for that work type and either independent work is proceeding or the task is safely paused awaiting a stated condition.

If a blocked PR is being considered for Ready for Review, apply the repository's applicable Ready-for-Review policy and make any incomplete criteria or blockers explicit. Do not invent a stricter readiness gate in this Skill.

### Prepare a handoff

Use before stopping unfinished work or transferring it to another executor.

For PR-backed work:

1. Inspect the actual repository and checks; do not summarize the conversation.
2. Update `Current State` with completed work, remaining work, blockers/constraints, any material decision required to continue safely, and the exact next action.
3. Update `Validation` with checks run, results, checks not run, and the reason for important outstanding validation.
4. Use `Notes` only for useful risks, limitations, follow-ups, material decisions, or review focus.
5. Comment only if current-state replacement would lose important history or another person needs action/notification.
6. Re-check that the written snapshot agrees with repository facts.

For Issue-only non-repository work, perform the same handoff normalization on the Issue execution record: completed work, remaining work, blocker/constraints, validation state, material decisions needed to continue safely, and the exact next action. Use comments only for exception communication/history, not as a second current-state record.

**Complete this operation when:** an executor with no access to prior chat can recover and continue safely from the canonical GitHub surface alone.

### Prepare for Ready for Review

Use when a repository-changing implementation appears complete and the PR is still Draft.

1. Re-read the linked Issue and evaluate every acceptance criterion against the implementation.
2. Inspect the final diff for unintended or unrelated changes.
3. Run appropriate repository validation available within the current environment and authority.
4. Update `Validation` with exact checks and outcomes; explicitly state important validation not run and why.
5. Update `Current State` so it contains no stale remaining work. If anything is intentionally incomplete, make that explicit and record the exact next action.
6. Use `Notes` only for material risks, limitations, follow-ups, decisions, or review focus.
7. Confirm the PR has a valid closing Issue link.
8. Apply the repository's applicable Ready-for-Review policy from its authoritative instructions and workflow documentation. Do not tighten or redefine that policy in this Skill. When incomplete criteria, blockers, or limitations are allowed by repository policy, make them explicit.
9. Change the PR from Draft to Ready for Review only when the authority rule above permits that collaboration-state transition. Otherwise stop after the PR is accurately prepared and report that it remains Draft pending explicit transition authority.

**Complete this operation when:** the PR satisfies the repository's applicable Ready-for-Review policy and its durable state and validation are accurate; if transition authority exists, the PR is Ready for Review, otherwise it remains correctly prepared in Draft.

Do not claim validation that was not performed.

### Review a Pull Request

Use when the user's requested task is to evaluate a PR rather than implement it.

Review evidence in this order:

1. linked Issue objective and acceptance criteria,
2. repository diff and relevant surrounding code,
3. tests, CI, and other validation evidence,
4. PR `Current State`, `Validation`, and useful notes,
5. historical comments only when needed for decision context.

Check for:

- unmet acceptance criteria,
- correctness or regression risks,
- missing validation,
- behavior that violates explicit constraints,
- unintended scope or unrelated changes,
- stale or misleading execution-state prose.

For each requested change, identify the concrete code location or artifact, explain the observable concern, and state the minimum correction needed. Do not request speculative refactors unrelated to the Issue.

If the implementation is acceptable, say so based on evidence and identify any remaining validation limitation.

**Complete this operation when:** findings or approval are grounded in the Issue, repository, and validation evidence, with each actionable finding tied to a concrete correction.

Do not modify implementation or GitHub execution state during review unless the user separately authorizes fixes.

## Stop conditions

Stop or change paths instead of improvising when:

- no executable Issue exists for repository-changing work,
- requirements are materially ambiguous and durable evidence cannot resolve them,
- required permission, credential, dependency, or approval is unavailable,
- the repository's applicable readiness policy does not permit transition to Ready for Review,
- the user's requested operation is read-only,
- a Draft-to-Ready collaboration-state transition lacks explicit user intent or repository delegation,
- a finalizing action such as merge or close lacks explicit authority.

When stopping for a recoverable blocker, leave the durable ledger in a state that states what is blocked and what happens next, using the canonical surface for the work type.

## Verification before exit

Before finishing any write-capable operation, verify only the artifacts that operation should have changed:

- the Issue remains the task definition, and for intentionally Issue-only non-repository work it also accurately holds current execution state,
- the PR body is the single current execution snapshot once repository-changing work has a PR,
- durable evidence and execution-state prose agree,
- validation claims are supported by checks or evidence actually obtained,
- comments contain only exception communication/history,
- the next executor or reviewer can determine the next action without prior chat.

Prefer deterministic repository or CI enforcement for machine-checkable guarantees. This Skill guides behavior; it is not an authorization boundary and does not replace repository governance.
