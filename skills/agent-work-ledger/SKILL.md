---
name: agent-work-ledger
description: Operate GitHub work that follows the Agent Work Ledger protocol: start or resume Issue/PR work, handle blockers or handoffs, prepare Draft PRs for Ready for Review, or review PRs. Use when repository policy makes Issues the task definition, PRs the execution record for repository work, and GitHub artifacts the durable source of truth.
---

# Agent Work Ledger

Use durable GitHub state instead of prior chat history. Read and follow the applicable `AGENTS.md` first; repository policy is authoritative and this Skill is only an operational router.

Do not read `docs/AGENT_WORKFLOW.md` on the normal execution path. Consult it only when changing this workflow, resolving policy ambiguity, or when a repository-specific detail is not covered by `AGENTS.md` or the selected reference.

## Contract

For each request:

1. infer the lifecycle operation from user intent and current Issue/PR shape,
2. select the smallest matching path before broad investigation,
3. recover only the live state needed for that path,
4. act within user authority, repository policy, and runtime permissions,
5. update only the canonical execution surface when state materially changes,
6. stop at an observable outcome or explicit blocker.

Repository facts override stale prose. Persist conclusions, evidence, decisions, blockers, validation, and next actions—not private chain-of-thought.

## Authority

- Implementation, execution, continue, and resume requests permit work-item changes and canonical-state updates subject to repository policy and runtime permissions.
- Blocker and handoff requests permit the state updates needed to leave work recoverable.
- Preparing a Draft PR for review permits validation and PR-body normalization. Moving Draft to Ready requires explicit user intent or clear repository delegation.
- Review is read-only unless fixes are separately requested.
- Merge, close, or other finalizing actions require explicit user intent or clear repository delegation.

Prompt text is not an authorization boundary; runtime and tool permissions remain authoritative.

## Route first

Load only the reference for the selected path. Do not preload every lifecycle procedure.

| Path | Reference | Minimum live state |
| --- | --- | --- |
| Start repository or Issue-only work | `references/start.md` | Issue objective/criteria, applicable policy, relevant repository evidence |
| Continue/resume PR work | `references/resume.md` | Issue criteria, PR current state, then relevant repository evidence |
| Blocker or handoff | `references/blocker-handoff.md` | Canonical current state plus evidence needed to verify blocker/resume state |
| Prepare for Ready | `references/ready.md` | Issue criteria, final relevant changes, validation/check summary, readiness policy |
| Review PR | `references/review.md` | Issue criteria, relevant changes/surrounding code, validation limits |

If the operation changes materially, load the new path reference then; otherwise keep one lifecycle reference in context.

## Progressive retrieval

Use `index/summary -> select -> expand`, not `load everything -> filter`.

### Pull Requests and code

1. Read PR metadata/body without the full diff.
2. Read changed filenames and compact stats.
3. Select files relevant to the current operation.
4. Fetch per-file patches for those files.
5. Fetch surrounding source only where the patch is insufficient.

Do not fetch a full PR diff by default. It is acceptable only when the change is demonstrably small and the whole diff is relevant.

### Checks and CI

Start with combined/check summaries. On failure, expand only the failed job, then the failed step or relevant log slice needed for diagnosis. Do not load complete CI logs by default.

### Review feedback

Start with unresolved actionable review threads. Expand the referenced patch/source as needed. Read resolved discussions or broader review history only when current unresolved state cannot explain a material decision or discrepancy.

### Issue and PR history

Do not fetch historical Issue/PR comment history on the normal path. Read it only when canonical current state is insufficient, repository facts conflict with prose, or a material decision needs historical context.

## Stop conditions

Stop or switch paths rather than improvising when required Issue context is absent, requirements remain materially ambiguous, required permissions/dependencies/approvals are unavailable, readiness policy blocks transition, a read-only request would require mutation, or a finalizing action lacks authority.

For recoverable stops, leave the canonical execution surface accurate enough to state what is blocked and what happens next.

## Exit check

Before finishing a write-capable operation, verify only what that path should have changed:

- canonical execution state matches durable evidence,
- validation claims are supported by checks actually performed,
- comments remain exception-only,
- a next executor or reviewer can determine the next action without prior chat.

Prefer deterministic repository or CI enforcement for machine-checkable guarantees.
