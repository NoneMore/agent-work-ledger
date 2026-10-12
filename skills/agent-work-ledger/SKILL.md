---
name: agent-work-ledger
description: GitHub durable work-state workflow for tracking, recovery, blockers/handoffs, review state, feedback state, and lifecycle transitions.
disable-model-invocation: true
user-invocable: true
---

# Agent Work Ledger

This Skill is the authoritative Agent Work Ledger workflow-state protocol.

## Responsibility boundary

Agent Work Ledger is a durable workflow-state controller and ledger. It owns canonical work state and authorized state transitions. It does not own substantive project work or executor orchestration.

The ledger may:

- determine or recover the canonical tracking surface;
- compare durable state with current GitHub facts;
- correct stale canonical state when authoritative evidence establishes the correction and mutation is authorized;
- identify explicit blockers, outstanding obligations, feedback state, validation evidence, and exact next actions;
- apply authorized Issue/PR lifecycle and state mutations;
- preserve resumable handoff state.

The ledger does not:

- choose product, domain, architecture, or interface direction;
- invent or materially reinterpret requirements;
- decide substantive decomposition boundaries;
- implement production changes;
- choose validation strategy beyond explicit task or repository requirements;
- perform substantive review or determine technical correctness;
- select, invoke, dispatch, or coordinate a person, agent, Skill, capability, or other executor for missing substantive work.

A missing substantive outcome is state, not an invitation for the ledger to produce or dispatch that outcome. Make the unmet outcome and exact next action explicit, then stop. If ownership, authority, or the next substantive choice is not already established by user intent or authoritative project state, ask the user rather than guessing.

## Shared protocol

GitHub is the durable system of record for agent work. Preserve enough state for another agent or human to resume without prior chat; do not duplicate routine progress across surfaces.

### Invariants

1. **Use an Issue when work needs an independent lifecycle.** Problems, requests, user-visible outcomes, coordination, and multi-PR efforts normally qualify. Routine maintenance may be PR-only when its PR is a complete public work item. For exploratory shaping, create or adopt an Initiative Issue only when durable tracking is explicitly requested or required by repository policy; otherwise do not manufacture tracking solely because shaping is occurring.
2. **Distinguish exploratory initiatives from executable Issues.** Executable Issues should be independently reviewable deliverables; exploratory initiatives may retain the durable problem/decision lifecycle while executable child work evolves beneath them. Do not infer executable commitment from detail, completeness, or a next step: candidate directions require explicit authorized acceptance, and implementation-local unknowns may remain.
3. **Repository changes use `branch -> first meaningful commit -> Draft PR`.** Issue-backed branches normally use `agent/<issue-number>-<slug>`; standalone maintenance uses `agent/maintenance-<slug>`. Branch names record origin, not current tracking mode. The ledger may establish tracking/lifecycle surfaces, but it does not manufacture the first meaningful repository change.
4. **Canonical ownership is singular by responsibility.** The Issue owns task definition and Issue-only state, including exploratory shaping; once a concrete repository-changing slice has a PR, its body owns that slice's execution state. `## Tracking` declares tracking mode; `Current State` and `Validation` are replacement snapshots, not logs. When the user or established project policy designates a durable product or architecture contract source, that source owns current contract truth. The ledger may record reconciliation against that source but does not create, choose, or substantively update the contract merely as a bookkeeping side effect.
5. **Validation is recorded evidence, not ledger-selected strategy.** Preserve validation actually performed, its result, validation explicitly reported as not performed, and explicit task/repository-required validation still outstanding. Do not independently decide what additional validation would be sufficient.
6. **GitHub inputs keep native roles.** Issue = tracked task definition or initiative; Issue comments = discussion/input; PR = execution artifact; PR comments/reviews/threads = feedback. Treat authorship as provenance, not authority; adopt existing Issues/PRs in place. User instructions provide intent, authority, or context rather than another ledger surface; mutations still require user intent, repository policy, or clear delegation.
7. **Comments are communication/history, not checkpoints or current-state stores.** When authorized Issue-comment input materially changes task definition, Issue-only state, or exploratory shaping state, update the Issue; PR-backed execution state stays in the PR body. Do not mirror native input/feedback merely for bookkeeping.
8. **Repository facts override stale ledger or execution prose.** Correct stale canonical work state during authorized write work; report mismatches during read-only state inspection. This rule does not make implementation or tests authoritative over a designated product or architecture contract source.
9. **State changes require evidence.** Do not mark substantive work, review, correction, validation, reconciliation, or handoff as complete merely because it was planned, requested, delegated, or discussed. Advance state only when authoritative evidence establishes the new fact.
10. **Do not persist hidden chain-of-thought.** Persist only conclusions, evidence, decisions, constraints, blockers, validation, feedback state, and next actions useful to future work.
11. **Do not duplicate native child-work state on parent initiatives.** Parent Issues may record child relationships, dependencies, accepted direction, and remaining parent-level acceptance, but should not mirror child open/closed state or maintain a second completion checklist when GitHub already owns that state on the child Issues.
12. **Do not orchestrate substantive work.** The ledger may state that design, specification, decomposition, implementation, evaluation, investigation, review, or another substantive outcome is still required. It does not decide who should produce it or invoke another capability to do so.

Standalone maintenance is a tracking choice, not a risk class. If it later needs an independent lifecycle, create an Issue, replace the standalone `## Tracking` declaration with Issue closing link(s), and keep the branch.

`Ready for Review` is a PR state, not a lifecycle operation. Before leaving Draft, account for tracking mode, intended scope, linked-Issue acceptance criteria when applicable, current state, recorded validation and any explicit required validation still outstanding, contract reconciliation when applicable, and material unresolved feedback. Transition only with explicit user intent or clear repository delegation. If determining any prerequisite requires substantive judgment not already established by authoritative evidence, leave that prerequisite outstanding instead of inferring it.

For executable Issues, a **Contract Impact** note is optional and describes only an already-established material durable-contract delta. If the user or established project policy has designated the affected contract source, name it. If no source is designated, do not create or designate one merely to populate Contract Impact or satisfy ledger reconciliation. Whether a durable contract changes and what that change means is not a ledger judgment.

### Minimum PR snapshot

Every repository-changing PR must contain:

- `## Tracking`: exactly one mode — Issue closing link(s), or `Standalone maintenance: <brief reason or scope>`,
- `Current State`: done work established by evidence, remaining repository-execution work, and the exact next action if unfinished; do not duplicate GitHub PR lifecycle state such as Ready, review, approval, or merge,
- `Validation`: checks actually run/results, including explicitly reported important checks not run and any explicit required validation still outstanding,
- `Contract Reconciliation`: current reconciliation state — `No durable contract change.`, `No contract source designated.`, `Pending: <source(s)>` while designated source(s) still need updates, or `Updated: <source(s)>` after authoritative evidence establishes reconciliation.

`Pending:` is valid only for unfinished work. Before leaving Draft, use a terminal reconciliation state that matches authoritative state. `No contract source designated.` does not authorize the workflow to create one.

Before stopping or handing off unfinished work, make the canonical execution surface sufficient to resume without prior chat. Before completing Issue-backed work, reconcile the Issue's acceptance criteria against authoritative evidence; do not infer substantive acceptance from the existence of a repository change. If that reconciliation requires unresolved judgment, leave it outstanding and ask the user when the needed authority or decision is unclear.

### Recovery budget

Load only what the current state operation needs:

1. **Canonical state:** PR metadata/body when a concrete PR execution surface exists; otherwise the relevant Issue execution or shaping state when one exists.
2. **Task definition:** for Issue-backed executable state/completion checks, read every closing-linked Issue's objective/acceptance criteria, relevant Context references, and any explicit `Contract Impact` that constrains the state being checked. Read only relevant current designated-contract content when it is needed to determine reconciliation or an explicit workflow obligation.
3. **Current input:** inspect Issue comments only when the operation is triggered by or explicitly references them, canonical state points to a pending comment/decision, or user intent/repository policy requires them; never scan comments merely to discover possible changes.
4. **Repository evidence:** changed filenames/stats, selected patches, and surrounding source only when needed to verify an objective repository fact that affects workflow state. Do not turn state recovery into implementation or review.
5. **Validation/feedback:** check summaries, failed job/step slices, current review state, unresolved PR feedback, or feedback blockers only when they affect the selected state operation.
6. **History:** older/resolved Issue or PR discussion only when canonical state plus current evidence cannot explain a material state discrepancy.

Do not preload full diffs, CI logs, linked-Issue history, or comment/review history.

## Select the state operation

Load exactly one reference; switch only when the state operation changes.

| Operation | Reference |
| --- | --- |
| Reconcile initiative-level shaping and parent-acceptance state | `references/shape.md` |
| Establish tracking/lifecycle state for executable work | `references/start.md` |
| Reconcile active executable-work state | `references/resume.md` |
| Record blocker or resumable handoff state | `references/blocker-handoff.md` |
| Reconcile PR review state | `references/review.md` |
| Reconcile PR feedback state | `references/feedback.md` |

GitHub input surfaces do not create routes. Existing PRs select the operation requested by the user or required by current state; Issue comments stay in the active Issue-backed state surface unless their effect changes that state; PR comments/reviews/threads use `feedback` only when feedback state is the work being reconciled.

Use `shape` for initiative-level state and `start`/`resume` for a concrete executable slice. A next exploratory step alone does not make an initiative executable.

## State boundary

After selecting an operation, apply the shared recovery budget and matching reference only. Inspect current state, reconcile it with authoritative evidence, perform authorized state/lifecycle mutations, and stop when further progress depends on substantive work or judgment not already established.

Do not select or invoke another capability as a side effect of ledger execution. Do not convert an intended delegation into a completed or in-progress state. When the next substantive action, owner, or authority is unclear and cannot be derived without judgment, ask the user.
