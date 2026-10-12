---
name: agent-work-ledger
description: GitHub work control and durable state workflow for initiative shaping, executable work, blockers/handoffs, PR review coordination, and PR feedback coordination.
disable-model-invocation: true
user-invocable: true
---

# Agent Work Ledger

This Skill is the authoritative Agent Work Ledger workflow.

## Responsibility boundary

Agent Work Ledger is the work control plane. It owns work identity, lifecycle, coordination, durable state, and workflow-level next actions. It does not own the substantive project outcome merely because that outcome is the next thing the work needs.

The ledger may:

- determine or recover the canonical tracking surface;
- identify current obligations, remaining work, blockers, and the next workflow-level action from durable task state;
- route substantive work to the appropriate executor or capability;
- maintain Issue/PR lifecycle and authority constraints;
- persist resulting decisions, progress, validation evidence, blockers, feedback disposition, and next actions;
- reconcile stale ledger state with authoritative repository facts.

The ledger does not independently:

- choose product, domain, architecture, or interface direction;
- invent or materially reinterpret requirements;
- decide substantive decomposition boundaries;
- implement production changes;
- choose a validation strategy beyond explicit task or repository requirements;
- perform substantive review or determine technical correctness.

Those outcomes belong to the active project capability or executor. The ledger may determine that one of those outcomes is required next, provide the durable context needed to perform it, and persist the resulting outcome.

## Shared protocol

GitHub is the durable system of record for agent work. Preserve enough state for another agent or human to resume without prior chat; do not duplicate routine progress across surfaces.

### Invariants

1. **Use an Issue when work needs an independent lifecycle.** Problems, requests, user-visible outcomes, coordination, and multi-PR efforts normally qualify. Routine maintenance may be PR-only when its PR is a complete public work item. For exploratory shaping, create or adopt an Initiative Issue only when durable tracking is explicitly requested or required by repository policy; otherwise do not manufacture tracking solely because shaping is occurring.
2. **Distinguish exploratory initiatives from executable Issues.** Executable Issues should be independently reviewable deliverables; exploratory initiatives may retain the durable problem/decision lifecycle while executable child work evolves beneath them. Do not infer executable commitment from detail, completeness, or a next step: candidate directions require explicit authorized acceptance, and implementation-local unknowns may remain.
3. **All repository changes use `branch -> first meaningful commit -> Draft PR`.** Issue-backed branches normally use `agent/<issue-number>-<slug>`; standalone maintenance uses `agent/maintenance-<slug>`. Branch names record origin, not current tracking mode.
4. **Canonical ownership is singular by responsibility.** The Issue owns task definition and Issue-only state, including exploratory shaping; once a concrete repository-changing slice has a PR, its body owns that slice's execution state. `## Tracking` declares tracking mode; `Current State` and `Validation` are replacement snapshots, not logs. When the user or established project policy designates a durable product or architecture contract source, that source owns current contract truth. The ledger may reference or modify a designated source when authorized by the substantive work, but it does not create or designate a contract persistence surface merely as a tracking or reconciliation side effect. An Issue may describe the work's contract delta and a PR may record reconciliation, but neither becomes a duplicate current-contract store.
5. **Validation is durable execution evidence.** The substantive executor owns validation selection and interpretation, subject to explicit task and repository requirements. The ledger owns preserving what validation was performed, its result, important validation not performed, and whether an explicit required validation obligation remains outstanding.
6. **GitHub inputs keep native roles.** Issue = tracked task definition or initiative; Issue comments = discussion/input; PR = execution artifact; PR comments/reviews/threads = feedback. Treat authorship as provenance, not authority; adopt existing Issues/PRs in place. User instructions provide intent, authority, or context rather than another ledger surface; mutations still require user intent, repository policy, or clear delegation.
7. **Comments are communication/history, not checkpoints or current-state stores.** When authorized Issue-comment input materially changes task definition, Issue-only state, or exploratory shaping state, update the Issue; PR-backed execution state stays in the PR body. Do not mirror native input/feedback merely for bookkeeping.
8. **Repository facts override stale ledger or execution prose.** Correct stale canonical work state during authorized write work; report mismatches during read-only coordination. This rule does not make implementation or tests authoritative over a designated product or architecture contract source.
9. **Do not persist hidden chain-of-thought.** Persist only conclusions, evidence, decisions, constraints, blockers, validation, and next actions useful to future work.
10. **Do not duplicate native child-work state on parent initiatives.** Parent Issues may record child relationships, dependencies, accepted direction, and remaining parent-level acceptance, but should not mirror child open/closed state or maintain a second completion checklist when GitHub already owns that state on the child Issues.
11. **Coordinate substantive work; do not absorb it.** The ledger may identify that design, specification, decomposition, implementation, evaluation, investigation, or another expert outcome is required next. It supplies the current durable context, delegates or routes that work, then records the result. It does not silently produce that substantive result as ledger policy.

Standalone maintenance is a tracking choice, not a risk class. If it later needs an independent lifecycle, create an Issue, replace the standalone `## Tracking` declaration with Issue closing link(s), and keep the branch.

`Ready for Review` is a PR state, not a lifecycle operation. Before leaving Draft, account for tracking mode, intended scope, linked-Issue acceptance criteria when applicable, current state, recorded validation and any explicit required validation still outstanding, contract reconciliation when applicable, and material unresolved feedback. Transition only with explicit user intent or clear repository delegation.

For executable Issues, a **Contract Impact** note is optional and describes only the work's material durable-contract delta. If the user or established project policy has already designated the affected contract source, name it. If no source is designated, do not create or designate one merely to populate Contract Impact or satisfy ledger reconciliation. Whether a durable contract changes and what that change means is a substantive judgment owned by the relevant project capability or authorized decision-maker; once that obligation is established, the ledger owns its reconciliation state.

### Minimum PR snapshot

Every repository-changing PR must contain:

- `## Tracking`: exactly one mode — Issue closing link(s), or `Standalone maintenance: <brief reason or scope>`,
- `Current State`: done, remaining repository-execution work, and exact next repository-execution action if unfinished; do not duplicate GitHub PR lifecycle state such as Ready, review, approval, or merge,
- `Validation`: checks actually run/results, including important checks not run and any explicit required validation still outstanding,
- `Contract Reconciliation`: current reconciliation state — `No durable contract change.`, `No contract source designated.`, `Pending: <source(s)>` while designated source(s) still need updates, or `Updated: <source(s)>` after they are reconciled.

`Pending:` is valid only for unfinished work. Before leaving Draft, use a terminal reconciliation state that matches the work and designated sources. `No contract source designated.` does not authorize the workflow to create one.

Before stopping or handing off unfinished work, make the canonical execution surface sufficient to resume without prior chat. Before completing Issue-backed work, reconcile the Issue's acceptance criteria against the delivered result; do not treat unchecked or stale criteria as completed merely because the repository change exists. Where that reconciliation requires substantive technical or product judgment, obtain that judgment from the appropriate executor rather than manufacturing it in the ledger.

### Recovery budget

Load only what the current operation needs:

1. **Canonical state:** PR metadata/body when a concrete PR execution surface exists; otherwise the relevant Issue execution or shaping state when one exists.
2. **Task definition:** for Issue-backed executable implementation/completion coordination, read every closing-linked Issue's objective/acceptance criteria, any Context references needed to route or execute safely (including an already-designated contract source that materially constrains implementation or completion), and any explicit Contract Impact that materially constrains the work. When a designated product or architecture contract source materially constrains implementation or completion, read only the relevant current contract content before routing or judging lifecycle obligations; treat Contract Impact as the requested or accepted delta against that source, not as a substitute for current contract truth. Inspect Issue comments only when the operation is triggered by or explicitly references them, canonical state points to a pending comment/decision, or user intent/repository policy requires them; never scan comments merely to discover possible changes. For exploratory initiative work with an Initiative Issue, use its current canonical shaping state; for untracked shaping, use the current request/context and selected evidence without creating tracking solely for recovery. For standalone work, use PR title/body.
3. **Repository evidence:** changed filenames/stats, selected patches, and surrounding source only when needed to establish routing, state, blockers, or the context required by a substantive executor.
4. **Validation/feedback:** check summary, failed job/step/log slice, current unresolved PR feedback, or feedback blockers only when relevant to the selected operation.
5. **History:** older/resolved Issue or PR discussion only when canonical state plus current input/evidence cannot explain a material decision or discrepancy.

Do not preload full diffs, CI logs, linked-Issue history, or comment/review history.

## Route first

Load exactly one reference; switch only when the operation changes.

| Operation | Reference |
| --- | --- |
| Coordinate initiative-level shaping or parent acceptance when the requested work is not a concrete executable delivery slice | `references/shape.md` |
| Establish tracking and execution state for repository or Issue-only executable work | `references/start.md` |
| Continue/resume active executable work by recovering obligations, routing the next substantive action, and persisting its result | `references/resume.md` |
| Blocker or handoff | `references/blocker-handoff.md` |
| Coordinate PR review when review is required or requested | `references/review.md` |
| Coordinate disposition and follow-up for PR feedback | `references/feedback.md` |

GitHub input surfaces do not create routes. Existing PRs route by the requested operation; Issue comments stay in the active Issue-backed path unless their effect requires another route; PR comments/reviews/threads use `feedback` when they become active work.

Use `shape` for initiative-level coordination, decision state, decomposition state, and parent acceptance state; use `start`/`resume` only when the requested work is delivery of a concrete executable slice. A next exploratory step alone does not make an initiative executable.

## Execution boundary

After routing, apply the shared recovery budget and selected reference only. The selected route may recover state, determine workflow obligations, request or invoke an appropriate substantive executor, and persist resulting durable state. It must not silently take ownership of design, specification, decomposition, implementation, validation strategy, technical review, or other substantive project outcomes merely because they are needed by the workflow.

Review coordination is read-only by default; authorized feedback handling may mutate GitHub coordination state and may route authorized correction work to an executor, but the ledger itself does not perform the substantive correction. Finalizing GitHub transitions require the authority defined above.

Stop or switch paths when required tracking context is missing, executable requirements remain materially ambiguous, a dependency/approval blocks work, a required substantive outcome has not yet been produced, or the requested action exceeds authority. Untracked shaping is not missing tracking context merely because no Initiative Issue exists; create or adopt one only when durable tracking becomes explicitly required or repository policy requires it. Leave recoverable blockers and the exact next action on the canonical surface when one exists.