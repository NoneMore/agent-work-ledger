---
name: agent-work-ledger
description: GitHub work ledger workflow for exploring/shaping initiatives, starting/resuming executable work, blockers/handoffs, PR review, and PR feedback.
disable-model-invocation: true
user-invocable: true
---

# Agent Work Ledger

This Skill is the authoritative Agent Work Ledger workflow.

## Shared protocol

GitHub is the durable system of record for agent work. Preserve enough state for another agent or human to resume without prior chat; do not duplicate routine progress across surfaces.

### Invariants

1. **Use an Issue when work needs an independent lifecycle.** Problems, requests, user-visible outcomes, coordination, and multi-PR efforts normally qualify. Routine maintenance may be PR-only when its PR is a complete public work item. For exploratory shaping, create or adopt an Initiative Issue only when durable tracking is explicitly requested or required by repository policy; otherwise do not manufacture tracking solely because shaping is occurring.
2. **Distinguish exploratory initiatives from executable Issues.** Executable Issues should be independently reviewable deliverables; exploratory initiatives may retain the durable problem/decision lifecycle while executable child work evolves beneath them. Do not infer executable commitment from detail, completeness, or a next step: candidate directions require explicit authorized acceptance, and implementation-local unknowns may remain.
3. **All repository changes use `branch -> first meaningful commit -> Draft PR`.** Issue-backed branches normally use `agent/<issue-number>-<slug>`; standalone maintenance uses `agent/maintenance-<slug>`. Branch names record origin, not current tracking mode.
4. **Canonical ownership is singular by responsibility.** The Issue owns task definition and Issue-only state, including exploratory shaping; once a concrete repository-changing slice has a PR, its body owns that slice's execution state. `## Tracking` declares tracking mode; `Current State` and `Validation` are replacement snapshots, not logs. When the user or established project policy designates a durable product or architecture contract source, that source owns current contract truth. The ledger may reference or modify a designated source when the work authorizes it, but it does not create or designate a contract persistence surface merely as a ledger tracking or reconciliation side effect. An Issue may describe the work's contract delta and a PR may record reconciliation, but neither becomes a duplicate current-contract store.
5. **Validation follows change risk.** Use affected validation for narrow changes and stronger validation for broad, dependency/build/CI, security-sensitive, or unclassifiable changes. Reduce expensive validation only from repository facts or authoritative rules.
6. **GitHub inputs keep native roles.** Issue = tracked task definition or initiative; Issue comments = discussion/input; PR = execution artifact; PR comments/reviews/threads = feedback. Treat authorship as provenance, not authority; adopt existing Issues/PRs in place. User instructions provide intent, authority, or context rather than another ledger surface; mutations still require user intent, repository policy, or clear delegation.
7. **Comments are communication/history, not checkpoints or current-state stores.** When authorized Issue-comment input materially changes task definition, Issue-only state, or exploratory shaping state, update the Issue; PR-backed execution state stays in the PR body. Do not mirror native input/feedback merely for bookkeeping.
8. **Repository facts override stale ledger or execution prose.** Correct stale canonical work state during authorized write work; report mismatches during read-only review. This rule does not make implementation or tests authoritative over a designated product or architecture contract source.
9. **Do not persist hidden chain-of-thought.** Persist only conclusions, evidence, decisions, constraints, blockers, validation, and next actions useful to future work.
10. **Do not duplicate native child-work state on parent initiatives.** Parent Issues may record child relationships, dependencies, accepted direction, and remaining parent-level acceptance, but should not mirror child open/closed state or maintain a second completion checklist when GitHub already owns that state on the child Issues.

Standalone maintenance is a tracking choice, not a risk class. If it later needs an independent lifecycle, create an Issue, replace the standalone `## Tracking` declaration with Issue closing link(s), and keep the branch.

`Ready for Review` is a PR state, not a lifecycle operation. Before leaving Draft, account for tracking mode, intended scope, linked-Issue acceptance criteria when applicable, current state, validation, contract reconciliation when applicable, and material unresolved feedback. Transition only with explicit user intent or clear repository delegation.

For executable Issues, a **Contract Impact** note is optional and describes only the work's material durable-contract delta. If the user or established project policy has already designated the affected contract source, name it. If no source is designated, do not create or designate one merely to populate Contract Impact or satisfy ledger reconciliation. The Issue records requested or accepted work, not current product or architecture contract truth.

### Minimum PR snapshot

Every repository-changing PR must contain:

- `## Tracking`: exactly one mode — Issue closing link(s), or `Standalone maintenance: <brief reason or scope>`,
- `Current State`: done, remaining repository-execution work, and exact next repository-execution action if unfinished; do not duplicate GitHub PR lifecycle state such as Ready, review, approval, or merge,
- `Validation`: checks actually run/results, including important checks not run,
- `Contract Reconciliation`: current reconciliation state — `No durable contract change.`, `No contract source designated.`, `Pending: <source(s)>` while designated source(s) still need updates, or `Updated: <source(s)>` after they are reconciled.

`Pending:` is valid only for unfinished work. Before leaving Draft, use a terminal reconciliation state that matches the work and designated sources. `No contract source designated.` does not authorize the workflow to create one.

Before stopping or handing off unfinished work, make the canonical execution surface sufficient to resume without prior chat. Before completing Issue-backed work, reconcile the Issue's acceptance criteria against the delivered result; do not treat unchecked or stale criteria as completed merely because the repository change exists.

### Recovery budget

Load only what the current operation needs:

1. **Canonical state:** PR metadata/body when a concrete PR execution surface exists; otherwise the relevant Issue execution or shaping state when one exists.
2. **Task definition:** for Issue-backed executable implementation/completion judgments, read every closing-linked Issue's objective/acceptance criteria, any Context references needed to execute safely (including an already-designated contract source that materially constrains implementation or completion), and any explicit Contract Impact that materially constrains the work. When a designated product or architecture contract source materially constrains implementation or completion, read only the relevant current contract content before acting; treat Contract Impact as the requested or accepted delta against that source, not as a substitute for current contract truth. Inspect Issue comments only when the operation is triggered by or explicitly references them, canonical state points to a pending comment/decision, or user intent/repository policy requires them; never scan comments merely to discover possible changes. For exploratory initiative work with an Initiative Issue, use its current canonical shaping state; for untracked shaping, use the current request/context and selected evidence without creating tracking solely for recovery. For standalone work, use PR title/body.
3. **Repository evidence:** `changed filenames/stats -> selected patches -> surrounding source`, as needed.
4. **Validation/feedback:** `check summary -> failed job/step/log slice`; current unresolved PR feedback or feedback blockers only when relevant.
5. **History:** older/resolved Issue or PR discussion only when canonical state plus current input/evidence cannot explain a material decision or discrepancy.

Do not preload full diffs, CI logs, linked-Issue history, or comment/review history.

## Route first

Load exactly one reference; switch only when the operation changes.

| Operation | Reference |
| --- | --- |
| Shape or evaluate an initiative at the parent level, including acceptance, when the requested work is not a concrete executable delivery slice | `references/shape.md` |
| Start repository or Issue-only executable work | `references/start.md` |
| Continue/resume active executable work | `references/resume.md` |
| Blocker or handoff | `references/blocker-handoff.md` |
| Review PR | `references/review.md` |
| Handle PR feedback | `references/feedback.md` |

GitHub input surfaces do not create routes. Existing PRs route by the requested operation; Issue comments stay in the active Issue-backed path unless their effect requires another route; PR comments/reviews/threads use `feedback` when they become active work.

Use `shape` for initiative-level exploration, decisions, decomposition, and parent acceptance; use `start`/`resume` only when the requested work is delivery of a concrete executable slice. A next exploratory step alone does not make an initiative executable.

## Execution boundary

After routing, apply the shared recovery budget and selected reference only. Review is read-only by default; authorized feedback handling may write only within its reference boundary. Finalizing GitHub transitions require the authority defined above.

Stop or switch paths when required tracking context is missing, executable requirements remain materially ambiguous, a dependency/approval blocks work, or the requested action exceeds authority. Untracked shaping is not missing tracking context merely because no Initiative Issue exists; create or adopt one only when durable tracking becomes explicitly required or repository policy requires it. Leave recoverable blockers and the exact next action on the canonical surface when one exists.
