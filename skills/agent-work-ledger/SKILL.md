---
name: agent-work-ledger
description: GitHub durable work-state workflow for tracking, recovery, reconciliation, blockers/handoffs, and lifecycle transitions.
disable-model-invocation: true
user-invocable: true
---

# Agent Work Ledger

Agent Work Ledger is a durable GitHub work-state reconciler. It owns where workflow state lives, keeps that state aligned with authoritative evidence, and applies authorized lifecycle/state mutations. It does not perform substantive project work or choose who performs it.

## Shared protocol

1. **Use one canonical surface per responsibility.** Issues own independently tracked task/initiative state; PR bodies own repository-execution snapshots once a PR exists; native comments/reviews remain the durable feedback surfaces; a designated product/architecture contract source owns current contract truth.
2. **Track only when tracking is useful.** Use an Issue for work that needs an independent lifecycle. Routine maintenance may be PR-only. Exploratory work may remain untracked unless durable tracking is requested or required.
3. **Repository changes use `branch -> first meaningful commit -> Draft PR`.** The ledger may create/adopt tracking surfaces and branches when authorized, but it does not manufacture a repository change just to advance the lifecycle.
4. **State follows evidence, not intent.** Planned, requested, delegated, or expected work is not completed work. Persist what authoritative GitHub/project state establishes; preserve unknown or outstanding state instead of inventing an answer.
5. **Unknown is valid durable state.** Missing review, unresolved feedback, unclear blocker cause, unknown contract obligation, or an unowned next action may remain explicit. Ask the user only when the requested ledger mutation itself cannot be completed safely without a user decision or authority.
6. **No substantive-work orchestration.** The ledger does not design, implement, perform technical review, decide contested product/technical correctness, choose validation strategy beyond explicit requirements, or select/invoke an executor. It may perform bounded factual inspection needed to establish a workflow fact.
7. **Mutations require authority.** Create/update/close Issue/PR state, resolve feedback, move Draft to Ready, approve/request changes, or merge only when user intent, repository policy, or clear delegation authorizes that mutation.
8. **Keep recovery progressive.** Read the canonical surface first, then only the task, repository/check, feedback, contract, or history evidence needed for the current state question.
9. **Do not duplicate state or hidden reasoning.** Keep current snapshots current; preserve conclusions, evidence, decisions, blockers, validation, and next actions, not routine progress logs or chain-of-thought.

## Canonical PR snapshot

Every repository-changing PR contains:

- `## Tracking`: exactly one mode — Issue closing link(s), or `Standalone maintenance: <brief reason or scope>`.
- `## Current State`: work established as done, what remains, and the exact next action when unfinished.
- `## Validation`: validation actually performed/results, explicit required validation still outstanding, and material reported limitations.
- `## Contract Reconciliation`: one of:
  - `No reconciliation indicated.` — authoritative task/project state does not currently establish a durable-contract reconciliation obligation;
  - `No contract source designated.` — a durable-contract impact is established but no source is designated;
  - `Pending: <source(s)>` — designated source(s) still require reconciliation;
  - `Updated: <source(s)>` — authoritative evidence establishes reconciliation.

`No reconciliation indicated.` is deliberately an evidence claim, not an independent semantic proof that no durable contract could possibly be affected.

Before leaving Draft, require only prerequisites established by authoritative state: valid tracking, no known unfinished required work, no explicit required validation outstanding, terminal contract-reconciliation state, and no known material feedback obligation blocking the transition. If a prerequisite is unknown, leave it outstanding. Transition only with applicable authority.

## Recovery budget

Load only what is needed:

1. canonical PR/Issue state;
2. linked task/initiative definition when it constrains the current state question;
3. relevant designated-contract content when reconciliation is at issue;
4. changed filenames/selected patches/source or check/log slices only when needed to establish an objective workflow fact;
5. current review/feedback state only when it affects the current state question;
6. history only to explain a material discrepancy.

Do not preload full diffs, complete CI logs, or full comment/review history.

## Operations

Load one reference for the requested ledger action:

| Operation | Reference |
| --- | --- |
| Establish or adopt durable tracking/execution state | `references/establish.md` |
| Reconcile existing state, including initiative/execution progress, validation, contract state, review/feedback, blockers, handoff, readiness, and completion | `references/reconcile.md` |

These are ledger operations, not project-work routes. If reconciliation exposes missing substantive work, record the unmet outcome and stop; do not dispatch it.
