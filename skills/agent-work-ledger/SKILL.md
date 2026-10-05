---
name: agent-work-ledger
description: Execute, resume, hand off, prepare, or review GitHub work that follows the Agent Work Ledger protocol. Use when working from a GitHub Issue or Pull Request in a repository where Issues define requested outcomes, PR bodies hold current execution state, comments preserve exception history, and repository changes/checks provide evidence.
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

- **Issue** — requested outcome, acceptance criteria, context, constraints.
- **PR body** — current execution state and validation.
- **Diff / commits / checks** — implementation and validation evidence.
- **Comments** — exception-only communication or history.

Repository facts override stale prose. Persist useful conclusions, evidence, decisions, constraints, blockers, and next actions; do not persist private chain-of-thought.

## Preconditions and authority

Require one of these task contexts:

- an executable Issue to implement,
- an existing PR to continue, recover, hand off, or prepare for review,
- an existing PR to review.

Use live repository and GitHub state rather than cached copies when it is cheaply recoverable.

Do not invent missing requirements, permissions, credentials, approvals, or validation results.

A request to implement or continue work permits changes needed for that work item, subject to repository policy and runtime permissions. A review request is read-only unless the user separately asks for fixes. During read-only review, inspect stale or contradictory PR state but report it as a finding rather than mutating GitHub state. Do not merge, close, or perform another finalizing action unless the user explicitly requests it or governing repository instructions clearly delegate that authority.

## Recover state before acting

For an existing PR, reconstruct state in this order:

1. linked Issue objective and acceptance criteria,
2. PR `Current State`, `Validation`, and useful notes,
3. current diff, commits, and relevant repository files,
4. CI/checks and unresolved review feedback when relevant,
5. historical Issue/PR comments only when current state or a material decision needs context.

If durable prose disagrees with repository facts, trust the repository. For an authorized write-capable operation, correct the stale execution snapshot before relying on it. For a read-only review, do not mutate the PR; record the mismatch as a review finding instead.

For a new Issue with no implementation PR, read the Issue and relevant repository evidence before changing code.

## Resolve the operation

Choose the operation from the user's request and current GitHub state. Do not require the user to name an internal lifecycle mode.

### Start implementation

Use when an executable Issue exists and repository-changing implementation has not yet produced its work PR.

1. Verify the Issue provides an actionable objective and acceptance criteria.
2. Inspect relevant code, tests, docs, and constraints.
3. If safe execution is blocked by material ambiguity or a dependency, use the blocked path instead of guessing.
4. Create or use `agent/<issue-number>-<short-slug>` when the repository follows the default branch convention.
5. Make the first meaningful repository change before opening a Draft PR.
6. Open a Draft PR linked with `Closes #N`, `Fixes #N`, or `Resolves #N`.
7. Initialize the PR body so `Current State` states what is done, what remains, and the exact next action; initialize `Validation` accurately.
8. If the user requested full implementation, transition immediately into **Continue or resume implementation** and keep working until the requested scope is complete or another lifecycle path / stop condition applies. If the user requested only initialization or starting the work, stop after the Draft PR and its snapshot are valid.

**Complete this operation when:** either (a) the user requested only initialization and a meaningful implementation plus accurate Draft PR snapshot exist, or (b) a full implementation request has transitioned into the continuation path rather than stopping at PR creation.

For non-repository work where the protocol says no PR is needed, keep execution state on the Issue instead of creating an artificial PR.

### Continue or resume implementation

Use when an implementation PR already exists, whether the same executor is continuing or a new executor is recovering after interruption.

1. Recover state using the standard order above.
2. Verify the recorded next action against the repository.
3. If it is stale or underspecified, derive the smallest concrete next action from acceptance criteria and evidence, then update `Current State`.
4. Continue implementation without repeating already completed investigation unless verification is necessary.
5. When execution state materially changes, update the PR body rather than posting a routine progress comment.
6. Keep `Validation` current as checks run; state important checks not run and why.

`Current State` should make clear:

- what is complete,
- what remains,
- any blocker,
- the exact next action while unfinished.

**Complete this operation when:** the requested implementation scope or increment is finished and the PR snapshot again matches the repository, or another lifecycle path becomes necessary.

### Handle a blocker

Use when required progress cannot continue because of missing input, permission, dependency, unresolved constraint, or another concrete external condition.

1. Verify the blocker against available repository state, checks, configuration, and Issue constraints.
2. If a PR exists, update `Current State` with:
   - what cannot proceed,
   - the concrete reason,
   - concise evidence,
   - the condition or action that would unblock work,
   - useful work that can still continue independently,
   - the exact next action.
3. If a PR exists, update `Validation` when the blocker prevents a check from running; state what was not run and why.
4. If no PR exists yet, do not create an artificial PR and do not turn the Issue body into a second execution snapshot. Add a concise Issue comment only when another person must act, notification/discussion is needed, or important blocker history would otherwise be lost; otherwise report the blocker to the user and stop safely.
5. If a PR exists, add a comment only when another person must act, notification/discussion is needed, or important historical rationale would otherwise be lost.
6. Continue independent useful work when appropriate; otherwise stop at the blocker boundary.

**Complete this operation when:** the blocker is accurately represented at the appropriate durable surface and either independent work is proceeding or the task is safely paused awaiting a stated condition.

If a blocked PR is being considered for Ready for Review, apply the repository's applicable Ready-for-Review policy and make any incomplete criteria or blockers explicit. Do not invent a stricter readiness gate in this Skill.

### Prepare a handoff

Use before stopping unfinished work or transferring it to another executor.

1. Inspect the actual repository and checks; do not summarize the conversation.
2. Update `Current State` with completed work, remaining work, blockers/constraints, any material decision required to continue safely, and the exact next action.
3. Update `Validation` with checks run, results, checks not run, and the reason for important outstanding validation.
4. Use `Notes` only for useful risks, limitations, follow-ups, material decisions, or review focus.
5. Comment only if current-state replacement would lose important history or another person needs action/notification.
6. Re-check that the written snapshot agrees with repository facts.

**Complete this operation when:** an executor with no access to prior chat can recover and continue safely from GitHub alone.

### Prepare for Ready for Review

Use when implementation appears complete and the PR is still Draft.

1. Re-read the linked Issue and evaluate every acceptance criterion against the implementation.
2. Inspect the final diff for unintended or unrelated changes.
3. Run appropriate repository validation available within the current environment and authority.
4. Update `Validation` with exact checks and outcomes; explicitly state important validation not run and why.
5. Update `Current State` so it contains no stale remaining work. If anything is intentionally incomplete, make that explicit and record the exact next action.
6. Use `Notes` only for material risks, limitations, follow-ups, decisions, or review focus.
7. Confirm the PR has a valid closing Issue link.
8. Apply the repository's applicable Ready-for-Review policy from its authoritative instructions and workflow documentation. Do not tighten or redefine that policy in this Skill. When incomplete criteria, blockers, or limitations are allowed by repository policy, make them explicit before changing PR status.

**Complete this operation when:** the PR satisfies the repository's applicable Ready-for-Review policy, its durable state is accurate, required validation evidence is recorded, and the PR has been marked Ready for Review when permitted.

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
- requirements are materially ambiguous and repository evidence cannot resolve them,
- required permission, credential, dependency, or approval is unavailable,
- the repository's applicable readiness policy does not permit transition to Ready for Review,
- the user's requested operation is read-only,
- a finalizing action such as merge or close lacks explicit authority.

When stopping for a recoverable blocker, leave the durable ledger in a state that states what is blocked and what happens next, using the appropriate surface for whether a PR exists.

## Verification before exit

Before finishing any write-capable operation, verify only the artifacts that operation should have changed:

- the Issue still defines the requested work rather than duplicated current status,
- the PR body is the single current execution snapshot once a PR exists,
- repository facts and PR prose agree,
- validation claims are supported by checks actually performed,
- comments contain only exception communication/history,
- the next executor or reviewer can determine the next action without prior chat.

Prefer deterministic repository or CI enforcement for machine-checkable guarantees. This Skill guides behavior; it is not an authorization boundary and does not replace repository governance.
