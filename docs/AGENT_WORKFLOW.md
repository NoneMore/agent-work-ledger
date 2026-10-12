# GitHub-native Agent Workflow

Agent Work Ledger keeps GitHub workflow state durable without becoming the executor of the work it records.

The normative operational contract lives in [`../skills/agent-work-ledger/SKILL.md`](../skills/agent-work-ledger/SKILL.md). This document explains the model and its tradeoffs for humans and workflow maintainers; agents should not need it on the normal path.

## 1. Mental model

Each surface owns one kind of truth:

| Surface | Primary role |
| --- | --- |
| Issue | Independently tracked task/initiative definition and Issue-only state |
| PR body | Repository-execution snapshot |
| Issue comments | Durable discussion/input around Issue-defined work |
| PR comments/reviews/threads | Durable PR feedback |
| Commits/checks | Implementation and validation evidence |
| Designated contract source | Current durable product/architecture contract truth |
| GitHub Project | Portfolio/coordination view |

The ledger may inspect enough evidence to establish a workflow fact and may apply authorized state mutations. It does not turn that inspection into design, implementation, technical review, contested correctness judgment, validation-strategy selection, or executor orchestration.

That distinction keeps the ledger useful for recovery without making it a second execution framework.

## 2. Tracking and lifecycle

Repository-changing work normally follows:

```text
Issue-backed: Issue -> branch -> first meaningful commit -> Draft PR -> work/validation -> [Ready] -> [review/feedback] -> merge
PR-only:      branch -> first meaningful commit -> Draft PR -> work/validation -> [Ready] -> [review/feedback] -> merge
```

Use an Issue when the work needs an independent lifecycle: durable problem/request tracking, exploratory initiatives, multi-PR efforts, acceptance/discussion, or pre-PR work that must remain resumable. Routine maintenance may stay PR-only.

The ledger never creates a synthetic commit just to advance this lifecycle. If standalone work must stop before a PR exists and durable resumption is required, promote it to Issue-backed tracking when authorized; otherwise durable tracking remains an explicit prerequisite.

Exploratory initiatives may preserve current understanding, evidence, open questions, accepted decisions, child relationships, remaining parent-level acceptance, and established next action. Investigation, design, and decomposition themselves remain outside the ledger.

## 3. Evidence and reconciliation

State advances from authoritative evidence, not intent. Planned/delegated work, requested review/correction/validation, and expected contract updates remain outstanding until evidence establishes their result.

Unknown is also valid state. Missing review, unresolved feedback, unclear blocker cause, unknown contract obligation, or an unowned substantive next action need not trigger a user question. Ask only when the **requested ledger mutation itself** cannot safely proceed without a user decision or authority.

Reconciliation therefore has one generic shape:

```text
canonical surface
  -> minimum relevant authoritative evidence
  -> correct stale state
  -> apply authorized mechanical mutation
  -> leave remaining obligations/unknowns explicit
```

Evidence domains do not create separate workflow routes. Native review/feedback can establish durable dispositions without the ledger performing review; CI/source inspection can establish a blocker fact without the ledger designing its remedy; validation evidence can be recorded without inventing new validation requirements.

## 4. PR execution snapshot

Every repository-changing PR keeps four required sections:

| Section | Purpose |
| --- | --- |
| `Tracking` | Exactly one mode: closing Issue link(s) or standalone maintenance |
| `Current State` | Established completed work, remaining work, exact next action when unfinished |
| `Validation` | Validation actually performed/results plus explicit required validation still outstanding |
| `Contract Reconciliation` | Current evidence-backed reconciliation state |

`Current State` is a replacement snapshot, not a progress log. Native PR lifecycle state stays native.

The exact contract-reconciliation values are defined in `SKILL.md` and the PR template. `No reconciliation indicated.` exists so the ledger can represent “no current obligation is established” without claiming it independently proved that no durable contract could possibly be affected.

## 5. Recovery and transitions

Recovery is progressive: read the canonical Issue/PR first, then only the linked task/initiative definition, designated contract context, selected repository/check evidence, current review/feedback, or history needed for the state question. Full diffs, full CI logs, and complete discussion histories are not default recovery shortcuts.

Repository facts override stale execution prose, but code/tests do not silently replace a designated contract source.

Moving a PR from Draft to Ready requires authoritative state showing no known blocking required work, explicit required validation, pending contract reconciliation, or material unresolved feedback, plus authority for the transition. Unknown prerequisites stay outstanding rather than being guessed complete.

For Issue-backed work, a repository change does not mechanically prove substantive acceptance. For initiatives, child completion does not imply parent acceptance.

The governance Action checks deterministic structure only; it intentionally does not decide semantic readiness.

## 6. Operational shape

The Skill has two operations:

- [`references/establish.md`](../skills/agent-work-ledger/references/establish.md) — establish or adopt the canonical durable surface;
- [`references/reconcile.md`](../skills/agent-work-ledger/references/reconcile.md) — reconcile all existing workflow state.

This split is deliberately small. Initiative, execution, validation, review, feedback, blocker, handoff, readiness, completion, and contract concerns are evidence/state domains inside reconciliation rather than independent control-plane states.

For GitHub Projects, start with one `Status` field (`Inbox / Ready / In Progress / Blocked / Review / Done`) and add fields only when they provide real portfolio value.
