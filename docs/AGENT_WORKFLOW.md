# GitHub-native Agent Workflow

Agent Work Ledger keeps GitHub workflow state durable without turning the ledger into the executor of the work it records.

The operational contract lives in [`../skills/agent-work-ledger/SKILL.md`](../skills/agent-work-ledger/SKILL.md). This document explains the model for humans and workflow maintainers; agents should not load it on the normal path.

## 1. Responsibility boundary

The ledger owns:

- canonical placement of task/initiative/execution state;
- recovery and reconciliation after interruption;
- validation, feedback, blocker, handoff, and contract-reconciliation state;
- exact outstanding obligations/next actions;
- authorized GitHub lifecycle/state mutations.

The ledger does not own substantive project outcomes. Design, specification, implementation, technical review, contested correctness judgments, validation strategy beyond explicit requirements, and executor selection happen outside it.

The boundary is intentionally asymmetric: the ledger may inspect enough evidence to establish a workflow fact, but it must not turn that inspection into doing the missing project work.

## 2. Canonical surfaces

| Surface | Primary role |
| --- | --- |
| Issue | Independently tracked task/initiative definition and Issue-only state |
| PR body | Repository-execution snapshot |
| Issue comments | Durable discussion/input around Issue-defined work |
| PR comments/reviews/threads | Durable PR feedback |
| Commits/checks | Implementation and validation evidence |
| Designated contract source | Current durable product/architecture contract truth |
| GitHub Project | Portfolio/coordination view |

Do not maintain the same current state in multiple places. Once a concrete repository slice has a PR, its execution snapshot belongs in the PR body.

Authorship is provenance, not authority. Existing Issues/PRs are adopted in place.

## 3. Lifecycle and tracking

Repository-changing work normally follows:

```text
Issue-backed: Issue -> branch -> first meaningful commit -> Draft PR -> work/validation -> [Ready] -> [review/feedback] -> merge
PR-only:      branch -> first meaningful commit -> Draft PR -> work/validation -> [Ready] -> [review/feedback] -> merge
```

The ledger does not manufacture the first meaningful commit or perform the substantive work/review steps.

Use an Issue when work needs an independent lifecycle: durable problem/request tracking, initiatives, multi-PR efforts, acceptance/discussion, or pre-PR work that must remain resumable. Routine maintenance may be PR-only.

Exploratory initiatives may record current understanding, evidence, open questions, candidate/accepted decisions, child relationships, remaining parent-level acceptance, and established next action. Investigation/design/decomposition itself is outside the ledger.

If standalone work must stop before a PR exists and durable resumption is required, promote it to Issue-backed tracking when authorized; otherwise the absence of durable tracking remains an explicit prerequisite.

## 4. Evidence and unknown state

State advances only from authoritative evidence.

The following are not progress by themselves:

- planned work;
- delegated work;
- requested review/correction/validation;
- an expected contract update.

Unknown is valid durable state. Missing review, unresolved feedback, unclear blocker cause, unknown contract obligation, or unowned substantive work can remain explicit without immediately asking the user.

Ask the user only when the **requested ledger mutation** cannot safely proceed without a user decision or authority. Do not ask merely because the next substantive executor or outcome is unknown.

The ledger may perform bounded factual inspection needed to establish state. For example, reading the failed CI step far enough to distinguish “credential missing” from “test regression” is valid blocker classification; designing or applying the fix is not.

## 5. PR execution snapshot

Every repository-changing PR contains:

```markdown
## Tracking

Closes #123
<!-- OR: Standalone maintenance: <brief reason or scope> -->

## Current State

Established completed work, remaining work, and exact next action if unfinished.

## Validation

Validation actually performed/results, explicit required validation still outstanding, and material reported limitations.

## Contract Reconciliation

No reconciliation indicated.
<!-- OR: No contract source designated. -->
<!-- OR while unfinished: Pending: <source(s)> -->
<!-- OR when reconciled: Updated: <source(s)> -->

## Notes

Optional material limitations, risks, decisions, follow-ups, or review focus.
```

`Current State` is a replacement snapshot, not a progress log. Native PR lifecycle state (Draft/Ready/review/merge) stays native.

### Contract reconciliation

The field describes the evidence currently available:

- `No reconciliation indicated.` — authoritative task/project state does not establish a current durable-contract reconciliation obligation.
- `No contract source designated.` — an obligation is established but no persistence source is designated.
- `Pending: <source(s)>` — designated source(s) still need reconciliation.
- `Updated: <source(s)>` — evidence establishes reconciliation.

This avoids requiring the ledger to independently prove the negative claim that no durable contract could be affected. The ledger never creates/designates a contract source merely to fill the field.

## 6. Reconciliation

For existing work, use one reconciliation path regardless of whether the relevant evidence is initiative state, commits, validation, review, feedback, blockers, or contract state:

```text
canonical surface
  -> minimum relevant authoritative evidence
  -> reconcile stale state
  -> apply authorized mechanical mutation
  -> leave remaining obligations/unknowns explicit
```

Review and feedback are evidence domains, not separate control-plane routes. The ledger may record native review results or explicit feedback dispositions, but it does not perform technical review or invent a contested disposition.

Blockers and handoffs are also ordinary reconciliation state. Record the blocker, known unblock condition, material validation impact, established independent work, and exact next action. A handoff is complete when the canonical surface is sufficient to resume without prior chat.

## 7. Recovery budget

Recover progressively:

1. canonical PR/Issue state;
2. linked task/initiative definition if it constrains the current question;
3. designated contract content if reconciliation is at issue;
4. selected filenames/patches/source/check/log slices only to establish an objective workflow fact;
5. current review/feedback state only when relevant;
6. history only to explain a material discrepancy.

Do not preload full diffs, full CI logs, or complete comment/review history.

Repository facts override stale execution prose, but code/tests do not silently replace a designated product/architecture contract source.

## 8. Ready and completion

Before moving a PR from Draft to Ready, establish from authoritative state:

- one valid tracking mode;
- no known unfinished required repository work;
- no explicit required validation outstanding;
- terminal contract-reconciliation state;
- no known material unresolved feedback obligation that blocks the transition.

Unknown prerequisites remain outstanding. Moving Draft to Ready still requires applicable authority.

For Issue-backed work, acceptance criteria are complete only when authoritative evidence establishes completion. A repository change does not mechanically prove substantive acceptance. For initiatives, child completion does not imply parent acceptance.

The governance Action checks deterministic structure only; semantic readiness remains outside automated enforcement.

## 9. Operational Skill

The Skill has two operations:

- [`references/establish.md`](../skills/agent-work-ledger/references/establish.md) — establish/adopt durable tracking/execution state;
- [`references/reconcile.md`](../skills/agent-work-ledger/references/reconcile.md) — reconcile all existing workflow state.

This two-operation model is deliberate. Initiative, execution, validation, review, feedback, blocker, handoff, and contract concerns are evidence/state domains within reconciliation, not independent workflow state machines.

For GitHub Projects, start with one `Status` field (`Inbox / Ready / In Progress / Blocked / Review / Done`) and add fields only when they provide real portfolio value.
