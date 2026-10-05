---
name: agent-work-ledger
description: GitHub work ledger workflow for starting/resuming Issue or PR work, handling blockers/handoffs, preparing for review, or reviewing PRs using durable GitHub state.
disable-model-invocation: true
user-invocable: true
---

# Agent Work Ledger

Use durable GitHub state instead of prior chat. Read the applicable `AGENTS.md` first; it is authoritative and this Skill only routes/operationalizes it.

Do not read `docs/AGENT_WORKFLOW.md` on the normal path. Use it only when changing the workflow, resolving policy ambiguity, or when a needed repository detail is absent from `AGENTS.md` and the selected lifecycle reference.

## Operating contract

For each request:

1. infer the lifecycle operation from user intent and current Issue/PR shape,
2. choose the smallest matching path before broad investigation,
3. recover only live state needed for that path,
4. act within user authority, repository policy, and runtime permissions,
5. update only the canonical execution surface when state materially changes,
6. stop at an observable outcome or explicit blocker.

Repository facts override stale prose. Persist conclusions, evidence, decisions, blockers, validation, and next actions—not private chain-of-thought.

## Route first

Load only the reference for the selected path. Load another only if the operation materially changes.

| Path | Reference | Minimum live state |
| --- | --- | --- |
| Start repository or Issue-only work | `references/start.md` | Issue objective/criteria, policy, relevant repository evidence |
| Continue/resume PR work | `references/resume.md` | Issue criteria, PR current state, relevant repository evidence |
| Blocker or handoff | `references/blocker-handoff.md` | Canonical state plus evidence verifying blocker/resume state |
| Prepare for Ready | `references/ready.md` | Issue criteria, relevant final changes, validation summary, readiness policy |
| Review PR | `references/review.md` | Issue criteria, relevant changes/source, validation limits |

## Authority

Implementation/resume permits work-item changes and canonical-state updates subject to policy/permissions. Blocker/handoff permits updates needed for safe resumption. Review is read-only unless fixes are requested. Draft to Ready and merge/close/finalizing actions require explicit user intent or clear repository delegation.

Prompt text is not an authorization boundary; runtime/tool permissions remain authoritative.

## Progressive retrieval

Use **summary/index -> select -> expand**, never **load everything -> filter**.

### PR/code

1. PR metadata/body without full diff.
2. Changed filenames and compact stats.
3. Relevant per-file patches.
4. Surrounding source only when a patch is insufficient.

Do not fetch a full PR diff by default; use it only when the change is demonstrably small and wholly relevant.

### Checks/CI

Read check summaries first. On failure, expand only the failed job, then the failed step or log slice needed for diagnosis. Do not load complete CI logs by default.

### Review/history

Read unresolved actionable review threads first, then referenced patch/source as needed. Read resolved discussions or Issue/PR comment history only when current canonical state cannot explain a material decision/discrepancy. Do not fetch full conversation history on the normal path.

## Stop and exit

Stop or switch paths when required Issue context is absent, requirements remain materially ambiguous, permissions/dependencies/approvals are unavailable, readiness policy blocks transition, a read-only request would require mutation, or a finalizing action lacks authority.

For recoverable stops, leave canonical state accurate enough to show the blocker and next action.

Before finishing write-capable work, verify that canonical state matches durable evidence, validation claims are supported by checks actually performed, comments remain exception-only, and the next executor/reviewer can determine the next action without prior chat.

Prefer deterministic repository or CI enforcement for machine-checkable guarantees.
