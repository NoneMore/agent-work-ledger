---
name: agent-work-ledger
description: GitHub durable work-state workflow for tracking, recovery, reconciliation, blockers/handoffs, and lifecycle transitions.
disable-model-invocation: true
user-invocable: true
---

# Agent Work Ledger

Agent Work Ledger is a durable GitHub work-state reconciler. It owns where workflow state lives, keeps that state aligned with authoritative evidence, and applies authorized lifecycle/state mutations. It does not perform substantive project work or choose who performs it.

## Shared protocol

1. **Use one canonical surface per responsibility.** Issues own independently tracked task/initiative state; PR bodies own repository-execution snapshots; native comments/reviews own feedback; a designated product/architecture contract source owns current contract truth. Create tracking only when it has durable value; adopt existing surfaces instead of creating parallels.
2. **Repository changes use `branch -> first meaningful commit -> Draft PR`.** The ledger may create/adopt tracking surfaces and branches when authorized, but never manufactures a repository change to advance the lifecycle.
3. **State follows evidence; unknown is valid state.** Planned, requested, delegated, or expected work is not completed work. Preserve unknown/outstanding facts instead of inventing them, and ask the user only when the requested ledger mutation itself cannot safely proceed without a user decision or authority.
4. **Keep substantive work outside the ledger.** Do not design, implement, perform technical review, decide contested product/technical correctness, choose validation strategy beyond explicit requirements, or select/invoke an executor. Bounded factual inspection is allowed when needed to establish a workflow fact.
5. **Mutations require authority.** Create/update/close Issue/PR state, resolve feedback, move Draft to Ready, approve/request changes, or merge only with user intent, repository policy, or clear delegation.
6. **Recover progressively.** Read the canonical surface first, then only the task, repository/check, feedback, contract, or history evidence needed for the current state question.
7. **Keep snapshots singular and resumable.** Do not duplicate native state or routine progress across surfaces; persist conclusions, evidence, decisions, blockers, validation, and next actions, not hidden reasoning.

## Canonical PR snapshot

Every repository-changing PR contains:

- `## Tracking`: exactly one mode — Issue closing link(s), or `Standalone maintenance: <brief reason or scope>`.
- `## Current State`: work established as done, remaining work, and the exact next action when unfinished.
- `## Validation`: validation actually performed/results, explicit required validation still outstanding, and material reported limitations.
- `## Contract Reconciliation`: exactly one evidence-backed state:
  - `No reconciliation indicated.` — authoritative task/project state establishes no current reconciliation obligation;
  - `No contract source designated.` — an obligation is established but no source is designated;
  - `Pending: <source(s)>` — designated source(s) still require reconciliation;
  - `Updated: <source(s)>` — evidence establishes reconciliation.

Before leaving Draft, require authoritative state showing no known unfinished required work, explicit required validation, pending contract reconciliation, or material unresolved feedback that blocks the transition. Unknown prerequisites remain outstanding. The transition itself still requires authority.

For Issue-backed work, treat acceptance criteria as complete only when authoritative evidence establishes completion. For initiatives, child completion does not imply parent acceptance.

## Recovery budget

Load only what the current state question needs:

1. canonical PR/Issue state;
2. linked task/initiative definition when constraining;
3. designated contract content when reconciliation is at issue;
4. selected repository/check/log evidence needed to establish an objective fact;
5. current review/feedback when relevant;
6. history only to explain a material discrepancy.

Do not preload full diffs, complete CI logs, or full comment/review history.

## Operations

| Operation | Reference |
| --- | --- |
| Establish or adopt durable tracking/execution state | `references/establish.md` |
| Reconcile existing state across all evidence/state domains | `references/reconcile.md` |

These are ledger operations, not project-work routes. If reconciliation exposes missing substantive work, keep that outcome explicit and stop rather than dispatching it.
