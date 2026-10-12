# GitHub-native Agent Workflow

This repository uses GitHub Issues and Pull Requests as a durable work ledger and workflow-state controller without turning routine execution into paperwork.

This document is the detailed human/reference description of the workflow. Agents should not load it on the normal execution path: the explicitly invoked `skills/agent-work-ledger/SKILL.md` owns the shared invariants, recovery policy, lifecycle/state operations, responsibility boundary, and operation-specific references. Consult this document when changing the workflow, resolving policy ambiguity, or when a repository-specific detail is not covered by those smaller surfaces.

## 1. Responsibility boundary

Agent Work Ledger owns **durable workflow state**: work identity, tracking mode, canonical state placement, lifecycle state, recovery, blockers, validation evidence, feedback state, reconciliation state, handoff state, and authorized GitHub state transitions.

It does not own substantive project outcomes and does not orchestrate their production. It does not silently choose product/domain/architecture/interface direction, invent or materially reinterpret requirements, decide substantive decomposition boundaries, implement production behavior, choose validation strategy beyond explicit task/repository requirements, perform substantive technical review, select an executor, or invoke another capability.

The workflow is therefore:

```text
canonical work state
  -> recover authoritative GitHub facts
  -> reconcile stale state
  -> apply authorized state transition when evidence establishes it
  -> leave unmet obligation / exact next action explicit
  -> stop when further progress requires substantive work or judgment
```

An intended delegation, requested review, planned correction, or expected validation is not workflow progress by itself. The ledger advances state only when authoritative evidence establishes the new fact. If the next substantive action, owner, or authority is unclear and cannot be established without judgment, ask the user.

## 2. System of record

Each GitHub surface has one primary responsibility:

| Surface | Role |
| --- | --- |
| Issue | Defines problems, requests, exploratory initiatives, and executable work worth tracking independently |
| Issue comments | Durable discussion and input around Issue-defined work |
| Draft / open PR | Current repository execution snapshot and implementation artifact |
| PR conversation comments / reviews | Durable feedback on PR-backed work |
| Commits / checks | Implementation and validation evidence |
| GitHub Project | Cross-task progress view |

Avoid maintaining the same status in multiple places. Once an executable repository change has a PR, execution state belongs in the PR body rather than being duplicated into an Issue or comments. Exploratory initiative state remains on the parent Issue because that Issue owns the durable problem/decision lifecycle rather than a particular repository change.

When the user or established project policy designates a durable product or architecture contract source, that source remains the owner of current contract truth. An executable Issue may describe an established durable delta, and a PR records reconciliation state, but neither becomes a duplicate full-contract store. The ledger does not create, designate, or substantively change a contract source merely to satisfy tracking.

The ledger has four inbound GitHub shapes that matter to lifecycle handling: a new Issue, an Issue comment, an existing/new PR, and PR feedback through conversation comments or review surfaces. The surface gives input its default role; its durable effect determines whether task definition, shaping state, execution state, feedback state, blocker state, or authority actually changes.

Authorship does not change those roles. Existing Issues/PRs are adopted in place. Checks are evidence, Project fields are portfolio metadata, and direct user instructions provide intent/authority/context; none becomes another state store.

An Issue and a PR are not required to exist 1:1. Issues represent independently tracked work or initiatives; PRs represent repository changes.

## 3. Normal lifecycles

Executable Issue-backed work:

```text
Issue
  -> branch
  -> first meaningful commit
  -> Draft PR
  -> work / validation
  -> [mark Ready for Review when authorized]
  -> [review when required or requested]
  -> [PR feedback when present]
  -> merge
  -> Issue closed
```

Standalone repository maintenance:

```text
branch
  -> first meaningful commit
  -> Draft PR
  -> work / validation
  -> [mark Ready for Review when authorized]
  -> [review when required or requested]
  -> [PR feedback when present]
  -> merge
```

The ledger tracks and reconciles durable state around these lifecycles. It does not perform the substantive `work / validation`, review, correction, design, specification, decomposition, or acceptance judgment steps.

Exploratory initiative work may loop as evidence and decisions change:

```text
Initiative Issue
  -> investigation / framing / alternatives
  -> explicit accepted direction when authorized
  -> decomposition into executable child Issues when established
  -> child delivery / validation
  -> parent product/problem acceptance when established
  -> Initiative closed
```

The ledger records the initiative's current understanding, evidence, open questions, candidate versus accepted direction, child relationships, remaining parent-level acceptance, and established next action. It does not create the substantive content merely because that content is absent.

Contradictory evidence can require reconsidering an accepted direction. Record the evidence promptly, but reopen or replace the accepted direction only with the authority required to change that decision; otherwise leave reconsideration as the next action and stop downstream reliance when continuing would be unsafe.

`Ready for Review` is a GitHub PR state transition, not a separate lifecycle operation. Before leaving Draft, check only prerequisites that can be established from authoritative state: tracking mode, intended scope, linked-Issue acceptance state when already established, current state, explicit required validation, contract reconciliation, and material feedback. If a prerequisite requires unresolved substantive judgment, leave it outstanding. Transition only with explicit user intent or clear repository delegation.

Review is optional unless repository policy or explicit user intent requires it. The ledger can determine whether required review evidence exists and reflect native review consequences, but it does not perform review or select a reviewer.

The first meaningful commit gives GitHub something to compare against the base branch before the Draft PR is opened. The ledger does not manufacture that change merely to advance the lifecycle.

For work that does not produce repository changes but is worth tracking, keep execution or shaping state on the Issue instead of creating an artificial PR.

## 4. Issue intake

Use an Issue when the work should exist independently of any particular PR; for exploratory shaping, create/adopt an Initiative only when durable tracking is explicitly requested or required by repository policy. Typical independent-lifecycle cases include externally reported problems, product requests, work requiring durable discussion/acceptance, multi-PR efforts, migrations, risks, and durable follow-ups.

Do not create a synthetic Issue merely because repository files will change. Maintenance may start directly from a PR when the PR itself is a sufficient public record. This distinction is about tracking value, not change risk or size.

If standalone maintenance later develops independent tracking value, create an Issue, replace the standalone declaration in `## Tracking` with Issue closing link(s), and keep the branch.

### Executable Issues

An executable Issue should answer:

1. **Objective** — what durable outcome is required?
2. **Acceptance Criteria** — how do we know it is done?
3. **Context** — what information or references are needed to execute safely?
4. **Constraints** — what boundaries or non-goals matter?

Only Objective and Acceptance Criteria are required by the current Agent Task Issue Form. Context, constraints, dependencies, and `Contract Impact` are optional. Prefer paths, links, and durable decisions over copying large reference material into the Issue.

If durable state shows that execution is blocked by missing clarification, specification, design, decomposition, or another substantive prerequisite, record that prerequisite as outstanding. Do not produce it or decide who should produce it. Ask the user when a required choice of owner, authority, or next action is unclear.

Use `Contract Impact` only for a material durable-contract delta already established by authoritative input. If the user or established project policy has designated the affected contract source, name it. If no source is designated, do not create or designate one merely to populate `Contract Impact`.

Issue comments may clarify, constrain, or carry decisions, but they do not become a second task-definition store. When authorized input materially changes canonical Issue state, reflect the resulting durable state in the Issue and keep the comment as provenance.

Once repository execution moves into a PR, do not maintain a second `Current State` or `Next Action` on the executable Issue.

### Exploratory initiatives

Use an exploratory initiative when a durable problem/product outcome is worth tracking but the solution, accepted direction, or executable decomposition is not stable. Do not force premature executable semantics onto it.

The initiative may preserve:

- problem/opportunity;
- current understanding and established evidence;
- open questions;
- candidate versus accepted direction;
- explicitly accepted decisions;
- established child relationships/dependencies;
- remaining parent-level acceptance;
- established next action.

These are state responsibilities. Investigation, design, specification, decomposition, and substantive acceptance are outside the ledger. If current evidence does not establish the next shaping action, leave the uncertainty explicit and ask the user when a choice is required.

Decomposition does not complete the parent initiative. Parent Issues should not mirror child open/closed state when GitHub already owns that state on each child.

When exploratory work itself needs repository changes before the parent should close, give that concrete repository-changing slice its own executable Issue/PR surface. Do not use a closing link to the parent when merging the slice would not complete the parent lifecycle.

## 5. Executable-work state

For repository changes without a PR execution surface:

1. Choose the initial tracking path from user intent and repository policy.
2. Confirm that authoritative task state is sufficiently defined for tracking setup; if not, record the missing prerequisite and stop.
3. For Issue-backed work, create `agent/<issue-number>-<slug>` when authorized and useful.
4. For standalone maintenance, create `agent/maintenance-<slug>` when authorized and useful.
5. Do not manufacture a first meaningful repository change. After one exists, open a Draft PR and initialize its canonical snapshot.
6. Reconcile the PR body when authoritative evidence changes execution state, tracking mode, validation state, feedback consequences, blocker state, or contract reconciliation.

If work arrives as an existing PR, adopt it in place, infer/establish the correct tracking mode, and normalize the minimum PR snapshot during authorized write work. If write authority is unavailable, report the missing structure rather than creating a parallel ledger.

Branch naming is a creation convention and is not used to infer current tracking mode. `## Tracking` is canonical.

The minimum PR snapshot is:

```markdown
## Tracking

Closes #123
<!-- OR: Standalone maintenance: explain briefly why no separate Issue is useful. -->

## Current State

What repository-execution work is established as done, what remains, and the exact next repository-execution action if unfinished. Do not duplicate GitHub PR lifecycle state such as Ready, review, approval, or merge.

## Validation

Tests / checks actually run and their results. Note explicitly reported important checks not run and any explicit required validation still outstanding.

## Contract Reconciliation

No durable contract change.
<!-- OR while unfinished: Pending: <designated source(s)> -->
<!-- OR when reconciled: Updated: <designated source(s)> -->
<!-- OR when durable behavior change is established but no source has been designated: No contract source designated. -->

## Notes

Optional: limitations, risks, follow-ups, material decisions, or review focus.
```

Choose exactly one tracking mode in `## Tracking`. `Notes` are optional. Keep the snapshot about current work state; do not restate repository policy or task acceptance criteria merely for completeness.

`Contract Reconciliation` is a current state claim. Use `Pending:` while a designated source is known to require update, `Updated:` only after authoritative evidence establishes reconciliation, `No contract source designated.` when durable behavior change is established but no source is designated, and `No durable contract change.` only when that fact is established. The ledger does not choose or update a contract source merely to satisfy the field.

## 6. Validation

Validation is substantive evidence represented as durable workflow state.

The ledger records:

- validation actually performed and its result;
- validation explicitly reported as not performed;
- explicit validation required by task definition or repository policy that remains outstanding;
- validation-related blockers or limitations that already affect workflow state.

It does not select additional validation, apply an independent risk model, or decide substantive sufficiency beyond explicit requirements. If a transition depends on validation sufficiency that is not already established, leave that question outstanding.

## 7. Comments are for exceptions

Do not post routine claim or progress checkpoints.

Issue comments are durable discussion/input around Issue-defined work. PR review threads, reviews, and PR comments are durable feedback. Neither becomes a second current-state store.

Reflect a material state consequence in the canonical Issue/PR only when authoritative input or evidence changes that state. Respond in the native comment/review surface when communication is explicitly requested or useful and authorized; do not create substantive dispositions merely to clear feedback.

## 8. Recovery after interruption

Recovery is canonical-first and trigger-based. Load only enough context to determine current workflow state and whether authoritative evidence establishes a state transition.

1. Read PR metadata/body first when a PR execution surface exists; otherwise read the relevant Issue state.
2. Use `## Tracking` to identify task definition. Read closing-linked Issue objective/acceptance criteria and relevant Context/`Contract Impact` only when they affect the selected state check.
3. Read designated contract content only when needed to determine reconciliation or another explicit workflow obligation.
4. Inspect Issue comments only when directly relevant to the selected operation.
5. Read repository filenames/patches/source only when needed to verify an objective repository fact that affects state; do not turn recovery into implementation or technical review.
6. Read check summaries and native review/feedback state only when they affect the selected operation; expand failed logs only enough to establish the workflow fact at issue.
7. Read history only when current canonical state plus current evidence cannot explain a material discrepancy.

Do not use full diffs, complete CI logs, linked-Issue history, or full review/comment history as default recovery shortcuts.

Repository facts override stale ledger/execution prose, but code/tests do not override a designated product/architecture contract source merely by existing.

## 9. Leaving Draft

Before moving a PR out of Draft, establish from authoritative evidence:

- exactly one tracking mode;
- tracking mode still fits the work;
- linked-Issue acceptance state has no known outstanding criterion, without inventing substantive acceptance judgments;
- `Current State` matches repository facts;
- no explicit required validation remains outstanding;
- `Contract Reconciliation` is terminal (`No durable contract change.`, `No contract source designated.`, or `Updated: <source(s)>`);
- no known material unresolved feedback obligation blocks the transition.

If any prerequisite depends on substantive judgment not already established, keep it outstanding rather than inferring completion. Move Draft to Ready only with explicit user intent or clear repository delegation.

The governance workflow checks only deterministic structure: valid `## Tracking`, required PR snapshot headings, and no `Pending:` reconciliation on a non-Draft PR. It intentionally does not decide semantic readiness, acceptance, validation sufficiency, contract correctness, design correctness, or review correctness.

The versioned repository ruleset at [`.github/rulesets/main.json`](../.github/rulesets/main.json) is the enforcement counterpart for `main`: when applied, it requires PR-based changes and the `Validate Issue linkage and resumability` status check. Committing the JSON does not activate repository settings by itself.

## 10. Review and PR feedback state

### Review state

When review is required or requested, the ledger:

1. recovers native PR review/check/feedback state;
2. determines whether required review evidence exists;
3. records only workflow consequences already established by native review evidence;
4. leaves missing review or unresolved disposition explicit.

It does not inspect code to produce findings, select/invoke a reviewer, or turn a request for review into an in-progress/completed review state.

### Feedback state

For PR feedback, the ledger:

1. recovers native feedback and canonical PR state;
2. records mechanical facts such as unresolved items and explicit durable dispositions;
3. updates canonical execution state only when authoritative evidence establishes a material consequence;
4. leaves required evaluation, correction, clarification, evidence, or decisions outstanding when they have not occurred.

It does not decide contested correctness, produce corrections, choose validation, or select/invoke whoever should act. Responding/resolving threads requires authority and an already-established disposition; the ledger does not invent one for bookkeeping.

Approving, requesting changes, resolving threads, moving Draft to Ready, and merging are GitHub state mutations that require applicable authority.

## 11. Blockers and handoff

A blocker is durable workflow state. Record, when established:

- blocker;
- unblock condition when known;
- validation impact when applicable;
- remaining independently useful work already established;
- exact next action.

Do not diagnose the cause, choose the remedy, or assign an owner merely to make the ledger complete. If unblock condition, ownership, or authority is unclear and a choice is required, ask the user.

A handoff means the canonical surface is sufficient to resume without prior chat: current state, blockers/constraints, validation evidence, material decisions, pending substantive outcomes, and exact next action. It does not require the ledger to select or contact the next actor.

## 12. Completion

For Issue-backed repository work, linked Issues normally close through PR closing keywords. Before treating work as complete, reconcile acceptance criteria only against authoritative evidence; unchecked or stale criteria are not implicitly completed by the repository change. If substantive acceptance is not established, leave it outstanding.

If a designated contract source is known to require reconciliation, do not mark it updated until authoritative evidence establishes the update. If durable behavior change is established but no source is designated, use `No contract source designated.` rather than creating one.

For exploratory initiatives, child decomposition/delivery does not itself imply parent completion. Close the parent only when acceptance or abandonment/supersession is explicitly established with required authority.

For standalone maintenance, the merged PR is the complete durable record; do not create an Issue solely for bookkeeping.

## 13. Recommended Project configuration

The only default field is:

- `Status`: Inbox / Ready / In Progress / Blocked / Review / Done

Add fields only when the project genuinely benefits from maintaining them. Do not create a detailed shaping state machine in Project fields; the canonical Issue carries semantic state.

## 14. Operational Skill and context loading

[`../skills/agent-work-ledger/SKILL.md`](../skills/agent-work-ledger/SKILL.md) is the authoritative reusable workflow-state protocol.

The separation is intentional:

- `SKILL.md` owns responsibility boundaries, shared invariants, progressive recovery, lifecycle/state-operation selection, and authority boundaries;
- `skills/agent-work-ledger/references/` contains operation-specific state deltas; load exactly one unless the operation changes;
- substantive project work occurs outside the ledger;
- GitHub tools/APIs provide live Issue, PR, repository, check, and feedback state;
- the governance Action enforces only deterministic workflow structure;
- this document is detailed reference material, not a routine prompt dependency.

The retrieval model is deliberately trigger-based:

```text
canonical work surface
  -> relevant task/initiative definition
  -> designated contract context when materially constraining state
  -> selected repository/check/feedback evidence needed to verify state
  -> history only on discrepancy
```

The Skill should not cache task state, mechanically infer semantic readiness, preload evidence for later filtering, perform substantive work, or orchestrate an executor. Once invoked, it selects one state operation, reconciles authoritative evidence, applies authorized state mutations, and stops when further progress requires unresolved substantive judgment or action.
