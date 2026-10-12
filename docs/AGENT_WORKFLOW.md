# GitHub-native Agent Workflow

This repository uses GitHub Issues and Pull Requests as a durable work ledger and work control plane without turning routine execution into paperwork.

This document is the detailed human/reference description of the workflow. Agents should not load it on the normal execution path: the explicitly invoked `skills/agent-work-ledger/SKILL.md` owns the shared invariants, recovery policy, lifecycle routing, responsibility boundary, and operation-specific references. Consult this document when changing the workflow, resolving policy ambiguity, or when a repository-specific detail is not covered by those smaller surfaces.

## 1. Responsibility boundary

Agent Work Ledger owns **work control**: work identity, lifecycle, coordination, canonical state placement, blockers, durable progress, feedback state, handoff, and workflow-level next actions.

It is intentionally more than an activity log. The ledger may determine that the next obligation is to obtain a design decision, clarify a requirement, decompose work, implement a remaining acceptance criterion, evaluate a review concern, run explicitly required validation, or reconcile a designated contract source. It may recover the context needed for that obligation, route it to an appropriate executor, and persist the result.

The ledger does not independently own the substantive project outcome merely because that outcome is next. It does not silently choose product/domain/architecture/interface direction, invent or materially reinterpret requirements, decide substantive decomposition boundaries, implement production behavior, select validation strategy beyond explicit task/repository requirements, or perform substantive technical review. Those judgments and outputs belong to the project capability, executor, or authorized decision-maker responsible for them.

The workflow therefore follows this pattern:

```text
canonical work state
  -> identify current obligation
  -> route substantive work when needed
  -> receive result/evidence
  -> persist durable state
  -> identify next obligation
```

The ledger should remain executor-agnostic. A repository may use dedicated design/specification/decomposition/implementation/review capabilities, a general coding agent, a human maintainer, or another system. The ledger coordinates the lifecycle without hard-coding a particular external skill suite.

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

When the user or established project policy designates a durable product or architecture contract source, that source remains the owner of current contract truth. An executable Issue may describe a proposed or accepted durable delta, and a PR records where the delivered change was reconciled, but neither should become a duplicate full-contract store. The ledger may coordinate updates to a designated source when substantive work authorizes them, but it does not create or designate a contract persistence surface merely as a tracking or reconciliation side effect. Code and tests are implementation/evidence surfaces unless the project explicitly makes them authoritative for that contract.

The ledger has four inbound GitHub shapes that matter to lifecycle handling: a new Issue, an Issue comment, an existing/new PR, and PR feedback through conversation comments or review surfaces. They do not form a separate generic `external input` lifecycle. The surface gives the input its default role; its effect determines whether task definition, shaping state, execution state, feedback disposition, blocker state, or authority actually changes.

Authorship does not change those roles. An externally opened Issue or PR is adopted through the same lifecycle rather than recreated. Checks are evidence, Project fields are portfolio/coordination metadata, and direct user instructions provide intent, authority, or context; none is a fifth GitHub ledger input surface.

An Issue and a PR are not required to exist 1:1. Issues represent independently tracked work or initiatives; PRs represent repository changes.

## 3. Normal lifecycles

Executable Issue-backed work:

```text
Issue
  -> branch
  -> first meaningful commit
  -> Draft PR
  -> coordinated work / validation
  -> [mark Ready for Review when authorized]
  -> [review when required or requested]
  -> [PR feedback when present -> coordinate feedback]
  -> merge
  -> Issue closed
```

Standalone repository maintenance:

```text
branch
  -> first meaningful commit
  -> Draft PR
  -> coordinated work / validation
  -> [mark Ready for Review when authorized]
  -> [review when required or requested]
  -> [PR feedback when present -> coordinate feedback]
  -> merge
```

In both executable paths, the ledger owns tracking, recovery, current obligations, and persistence. The substantive executor owns the actual implementation/design/specification/evaluation work and the validation strategy unless the task or repository explicitly prescribes validation.

Exploratory initiative work is different. It may loop as evidence changes and does not become executable merely because it has a next step:

```text
Initiative Issue
  -> coordinate investigation / framing / alternatives
  -> explicit accepted direction when authorized
  -> coordinate decomposition into executable child Issues when useful
  -> child delivery / validation
  -> coordinate parent product/problem acceptance
  -> Initiative closed
```

The ledger owns the durable shaping state: problem/current understanding, evidence, open questions, candidate versus accepted direction, child relationships, remaining parent-level acceptance, and next shaping obligation. Investigation conclusions, design judgments, decomposition boundaries, and substantive acceptance judgments come from the executor or decision-maker that owns them.

Contradictory evidence can require reconsidering an accepted direction. Record that evidence promptly, but reopen or replace the accepted direction only with the authority required to change that decision; otherwise leave reconsideration as the next action and stop downstream reliance when continuing would be unsafe. The workflow does not define a mechanical readiness score or require every unknown to disappear before downstream work begins; the important boundary is whether a direction has been explicitly accepted and is safe for downstream work to rely on.

`Ready for Review` is a GitHub PR state transition, not a separate lifecycle operation. Active work is responsible for checking intended scope, canonical state, acceptance criteria when Issue-backed, recorded validation and any explicit required validation still outstanding, contract reconciliation when applicable, and material feedback before leaving Draft. The transition itself requires explicit user intent or clear repository delegation. Do not copy Draft/Ready, review, approval, or merge state into `Current State`; GitHub owns those lifecycle facts while the PR body owns repository execution state.

Review is an available operation, not a mandatory lifecycle stage. It is required only when repository policy or explicit user intent requires it. The ledger coordinates review context and consequences; substantive findings and technical correctness judgments come from the review executor. PR feedback can arrive before or without formal review and may require evaluation, correction, clarification, a decision, or no change.

The first meaningful commit gives GitHub something to compare against the base branch before the Draft PR is opened. The change itself should be produced by the appropriate substantive executor rather than by the ledger merely to satisfy workflow setup.

For work that does not produce repository changes but is worth tracking, keep execution or shaping state on the Issue instead of creating an artificial PR.

## 4. Issue intake

Use an Issue when the work should exist independently of any particular PR; for exploratory shaping, the narrower bootstrap rule below applies. Typical cases include:

- externally reported problems or user-visible bugs,
- feature requests or product/documentation requests,
- work requiring discussion, prioritization, coordination, investigation, or explicit acceptance criteria before implementation,
- efforts likely to span multiple PRs or independently executable child Issues,
- migrations, risks, or follow-ups worth tracking even if no PR exists yet.

The decisive test is whether the work needs a lifecycle independent of the current PR: separate prioritization, discussion, exploration, acceptance, continuation across multiple PRs, or durable follow-up after the current change. Category examples are heuristics, not exemptions.

Do not create a synthetic Issue merely because repository files will change. Dependency maintenance, CI/build/release work, internal refactors, tests, documentation upkeep, developer tooling, formatting, and repository metadata may start directly from a PR when the PR itself is a sufficient public record.

This distinction is about **tracking value**, not change risk or size. A high-risk maintenance PR may still be PR-only and require strong substantive review/validation; a small user request may still deserve an Issue because it belongs in the public work queue.

If standalone maintenance develops independent tracking value after work starts, promote it to Issue-backed work: create an Issue, replace the standalone declaration in `## Tracking` with `Closes #N`, `Fixes #N`, or `Resolves #N`, and continue from the existing PR. Do not rename the existing branch solely to reflect this transition. Branch naming records how work started; `## Tracking` and the linked Issue are canonical for how it is tracked now.

### Executable Issues

An executable Issue should answer four questions:

1. **Objective** — what durable outcome is required?
2. **Acceptance Criteria** — how do we know it is done?
3. **Context** — what information or references are needed to execute safely?
4. **Constraints** — what boundaries or non-goals matter?

Only Objective and Acceptance Criteria are required by the current Agent Task Issue Form. Context, constraints, dependencies, and `Contract Impact` are optional because not every task needs them. Prefer paths, links, and durable decisions over copying large reference material into the Issue. When an already-designated contract source materially constrains execution or completion without itself changing, it belongs in Context rather than being manufactured into a `Contract Impact` delta.

The ledger may determine that an executable Issue is not sufficiently defined to proceed safely. It should identify the smallest missing substantive outcome — for example clarification, specification, a design decision, or decomposition — and route or leave that as the next action. It must not invent the answer merely to make the Issue executable.

Use `Contract Impact` when substantive work has established a material durable-contract delta. Describe only that delta. If the user or established project policy has already designated the affected contract source, name it. If no source is designated, do not create or designate one merely to populate `Contract Impact`; the Issue is a work definition, not the current contract store. Whether there is a material contract change and what it means is a substantive judgment; the ledger owns the reconciliation state once that obligation exists.

Issue comments may clarify, constrain, or carry decisions about executable work, but they do not become a second task-definition store. When authorized input materially changes the objective, acceptance criteria, constraints, blocker, or Issue-only execution state, reflect the resulting durable state in the Issue. Keep the comment as provenance/history; do not copy it verbatim merely for bookkeeping.

Once repository execution for that deliverable moves into a PR, do not maintain `Current State` or `Next Action` on the executable Issue. The Issue remains the task definition.

### Exploratory initiatives

Use an exploratory initiative when the durable problem, product outcome, or acceptance lifecycle is worth tracking but the solution, accepted direction, or executable decomposition is not yet stable. Create or adopt this Initiative surface only when durable tracking is explicitly requested or required by repository policy; otherwise do not manufacture tracking solely because shaping is occurring. Do not force premature Objective/Acceptance Criteria onto this work just to make it look executable.

The initiative should preserve only durable state useful to the next executor or decision-maker, for example:

- the problem or opportunity being explored,
- current understanding and material evidence,
- open questions or uncertainties that still matter,
- candidate directions, clearly distinguished from accepted decisions,
- an explicitly accepted direction when authority has made that decision,
- the smallest next investigation, decision, decomposition, or acceptance step,
- executable child work and the parent-level acceptance that remains after decomposition.

These are state responsibilities, not authority for the ledger to produce the substantive content. Candidate generation/comparison may require design work; evidence may require investigation; executable child boundaries may require decomposition; parent acceptance may require product or technical evaluation. Route those outcomes to the appropriate executor or decision-maker and persist the returned result.

Commitment is a decision, not a readiness test. Detail alone does not imply commitment: a polished proposal, prototype, or extensive research result remains a candidate until an authorized decision accepts it. When contradictory evidence invalidates an accepted direction, record the evidence and known child work that may need follow-up; reopen or replace the accepted direction only with the authority required to change that decision. Without that authority, leave reconsideration as the next action and do not continue downstream reliance when doing so would be unsafe.

Decomposition also does not complete the parent initiative. Child Issues should be independently executable and reviewable, while the parent may remain open as the durable product/problem acceptance surface across multiple deliveries. Parent initiatives may record child relationships, dependencies, accepted direction, and remaining parent-level acceptance, but should not mirror child open/closed state or maintain a second child-completion checklist when GitHub already owns that state on each child Issue.

When exploratory research or design itself requires repository changes before the parent should close, give that concrete repository-changing slice its own executable Issue/PR surface. Do not use a closing link to the parent initiative when merging the slice would not actually complete the parent lifecycle.

## 5. Execution and coordination

For executable repository changes that do not already have a PR execution surface:

1. Choose the initial tracking path before creating the branch.
2. Confirm that the work has enough durable definition to proceed. If not, identify and route the smallest missing substantive prerequisite instead of inventing it.
3. For Issue-backed work, normally create `agent/<issue-number>-<slug>` and later link the PR with `Closes #N`, `Fixes #N`, or `Resolves #N` in `## Tracking`.
4. For standalone maintenance, normally create `agent/maintenance-<slug>` and later declare `Standalone maintenance: <brief reason or scope>` in `## Tracking`.
5. Route the first meaningful repository change to the appropriate substantive executor.
6. Open a Draft PR and use its body as the single execution snapshot.
7. Recover remaining obligations from the task definition and current evidence, route the smallest concrete obligation that can responsibly proceed, then persist the returned result.
8. Update the PR body when execution state materially changes, including promotion from standalone to Issue-backed tracking.
9. Record validation actually performed and any explicit required validation still outstanding. Keep `Contract Reconciliation` accurate before leaving Draft or finalizing the work.

If work arrives as an existing PR, do not recreate its branch or PR merely to fit the normal creation sequence. Treat that PR as the execution artifact, infer or establish the correct tracking mode, and normalize the minimum PR snapshot during authorized write work. If write authority is unavailable, report the missing structure rather than creating a parallel ledger.

Branch naming is a creation convention and is not used to infer current tracking mode. The `## Tracking` section is the canonical machine-readable tracking declaration.

The minimum PR snapshot is:

```markdown
## Tracking

Closes #123
<!-- OR: Standalone maintenance: explain briefly why no separate Issue is useful. -->

## Current State

What repository-execution work is done, what remains, and the exact next repository-execution action if unfinished. Do not duplicate GitHub PR lifecycle state such as Ready, review, approval, or merge.

## Validation

Tests / checks run and their results. Note anything important not run, why, and any explicit required validation still outstanding.

## Contract Reconciliation

No durable contract change.
<!-- OR while unfinished: Pending: <designated source(s)> -->
<!-- OR when reconciled: Updated: <designated source(s)> -->
<!-- OR when durable behavior changes but no source has been designated: No contract source designated. -->

## Notes

Optional: limitations, risks, follow-ups, material decisions, or review focus.
```

Choose exactly one tracking mode in `## Tracking`; Issue-backed mode may contain one or more closing links. Governance reads tracking declarations only from that section; examples or historical text elsewhere in the PR body do not change the tracking mode. `Notes` are optional. Delete the section when it adds no value. Keep the snapshot about the work itself; do not restate repository policy or closing-linked Issue acceptance criteria unless needed to explain current state.

`Contract Reconciliation` is a current snapshot, not a promise. Use `Pending: <source(s)>` while designated source(s) still need updates and replace it with `Updated: <source(s)>` after reconciliation. Use `No contract source designated.` when a substantive executor has established a durable behavior change but the user/project has not designated a persistence source. That state does not authorize the ledger workflow to create or choose one. Use `No durable contract change.` when the relevant substantive judgment establishes no durable contract change. Do not copy the full current contract into the PR body.

A repository-changing exploratory slice uses the same PR execution workflow once it has been cut into a concrete executable unit. The parent initiative continues to own shaping and parent-level acceptance rather than duplicating the child PR's execution state.

## 6. Validation

Validation is both substantive execution evidence and durable workflow state.

The substantive executor owns selection and interpretation of validation, subject to explicit task and repository requirements. The ledger should not apply a second risk model that independently decides which tests or checks are sufficient.

The ledger owns recording:

- validation actually performed and its result;
- important validation the executor explicitly reports as not performed;
- explicit validation required by task definition or repository policy that remains outstanding;
- validation-related blockers or limitations that affect workflow state.

This distinction lets the ledger determine that a known required validation obligation is still incomplete without inventing additional validation strategy of its own.

## 7. Comments are for exceptions

Do **not** post routine claim or progress checkpoints.

For Issue-backed work, Issue comments are durable discussion/input around the Issue. Material changes to executable task definition, exploratory shaping state, or Issue-only execution state should be reflected in the Issue when authorized so later recovery does not depend on replaying comment history.

The PR body always owns PR-backed execution status. If work becomes blocked, update `Current State` there. Add a comment only when the blocker also needs notification, explanation, discussion, or durable historical context.

Other reasons to leave a comment include a material decision changing implementation direction, an important discovery invalidating earlier assumptions, a direct response to PR feedback, or a pause where the canonical execution surface alone is insufficient for safe resumption.

Review threads, submitted reviews, and PR conversation comments are durable feedback sources, not a replacement execution-state store. Do not copy feedback already present on GitHub into `Current State` merely to create another ledger. Update canonical PR state only when handling the feedback materially changes execution state. Respond on the existing GitHub feedback surface when communication or disposition belongs there.

Comments preserve useful communication, input, and history; they do not become a second current-state store.

## 8. Recovery after interruption

Recovery is canonical-first and trigger-based. The goal is to load only enough context to determine the next safe workflow action and, when needed, provide an appropriate substantive executor with the context required for its work.

1. If an executable PR exists, read its metadata/body first. For Issue-only executable or exploratory work, read the Issue canonical state.
2. Use `## Tracking` to identify the tracking source. For Issue-backed executable work, read every closing-linked Issue's objective/acceptance criteria and any explicit `Contract Impact` that materially constrains implementation or completion whenever the selected operation will continue implementation or judge lifecycle completion. When a designated product or architecture contract source materially constrains implementation or completion, read only the relevant current contract content before routing work or judging workflow obligations; treat `Contract Impact` as the requested or accepted delta against that source, not as a substitute for current contract truth.
3. Inspect Issue comments only when the current operation is triggered by or explicitly references them, canonical state points to a pending comment/decision, or user intent/repository policy requires them; do not scan comment history merely to discover possible task changes.
4. For exploratory initiative work, recover the durable problem/current understanding, explicit accepted decisions if any, material open questions, remaining parent-level acceptance when relevant, and the next useful initiative-level step.
5. When repository behavior matters to routing, state, blockers, or executor context, read changed filenames/stats, then selected patches, then surrounding source only where needed.
6. Read check summaries only when validation affects the current operation; expand failed jobs/steps only for diagnosis or to provide a substantive executor with required evidence. Read current PR feedback only when relevant to the selected operation.
7. Read older or resolved Issue/PR discussion only if current canonical state and current input/evidence cannot explain a material decision or discrepancy.

Do not use a full PR diff, complete CI logs, linked-Issue history, or full review/comment history as default recovery shortcuts. Small complete diffs are acceptable when demonstrably small and wholly relevant.

Repository facts win over stale ledger or execution prose. Correct stale canonical work state during authorized write work, or report the mismatch during read-only coordination. This rule does not make implementation or tests authoritative over a designated product or architecture contract source.

## 9. Leaving Draft

Before moving a PR out of Draft:

- exactly one tracking mode is explicit in `## Tracking`: Issue-backed or standalone maintenance;
- the selected tracking mode still fits the work; promote standalone work first if it has developed independent tracking value;
- every closing-linked executable Issue's acceptance criteria are satisfied or incomplete items are explicit for Issue-backed work;
- a closing link does not falsely imply completion of a parent initiative that still owns unresolved product/problem acceptance;
- `Current State` accurately represents the repository-execution work, including any material feedback blocker that changes execution state, without copying PR lifecycle state;
- validation actually performed is recorded and no explicit required validation obligation remains outstanding;
- `Contract Reconciliation` uses a terminal state that matches the work and designated sources: `No durable contract change.`, `No contract source designated.`, or `Updated: <source(s)>`; `Pending:` is not Ready;
- PR feedback blocks leaving Draft only when it remains actionable and material to intended scope or repository policy;
- an exact next repository-execution action is present if repository work is intentionally incomplete;
- optional limitations, risks, follow-ups, or review focus are recorded only when useful.

Where determining acceptance, validation sufficiency beyond explicit requirements, contract impact, or technical correctness requires substantive judgment, obtain that judgment from the appropriate executor or decision-maker. The ledger owns whether the resulting obligation is complete, not the specialist reasoning itself.

This is a transition check within active work, not a separate lifecycle path. Move Draft to Ready for Review only with explicit user intent or clear repository delegation. An already non-Draft PR never cycles through this check merely because feedback was handled; continue with the operation required by repository policy or user intent.

The governance workflow checks only the minimum deterministic requirements: `## Tracking` must contain either an Issue closing link or an explicit standalone-maintenance declaration, the PR body must contain actual `## Current State`, `## Validation`, and `## Contract Reconciliation` headings, and a non-Draft PR must not retain a `Pending:` reconciliation state. Tracking-like text outside `## Tracking` is ignored. The workflow intentionally does not attempt to decide whether an Issue is semantically ready, whether acceptance checkboxes are complete, whether validation is substantively sufficient, whether a terminal contract reconciliation claim is semantically correct, whether an accepted direction is correct, or whether routine progress has been logged.

The versioned repository ruleset at [`.github/rulesets/main.json`](../.github/rulesets/main.json) is the enforcement counterpart for `main`: when applied in GitHub, it requires changes to go through a Pull Request and requires the `Validate Issue linkage and resumability` status check before merge. The check name is retained for live-ruleset compatibility even though the check accepts both tracking modes. Committing the JSON does not activate repository settings by itself; an administrator must import or apply the ruleset, and the live ruleset should remain aligned with the versioned file.

## 10. Review and PR feedback

Review and feedback handling are separate coordination operations with different authority boundaries.

### Review coordination

Review is required only when repository policy or explicit user intent requires it. The ledger:

1. establishes intended scope from `## Tracking` and task definition;
2. recovers the minimum current PR/check/feedback context needed by the review executor;
3. routes substantive review to the appropriate reviewer/capability;
4. persists workflow consequences of the returned result without duplicating native GitHub feedback;
5. routes authorized correction work onward or records the next decision/blocker/action.

The ledger does **not** itself inspect code and declare technical findings as part of ledger policy. Substantive findings, no-findings conclusions, and correctness judgments belong to the review executor. A finding already present in a GitHub review/comment is durable there and need not be copied into the PR body unless it materially changes current execution state.

### Feedback coordination

GitHub-native PR feedback comes from inline review threads, submitted reviews, and top-level PR conversation comments. Existing GitHub feedback is already durable and remains its own source.

When feedback handling is authorized:

1. recover canonical PR/task state and only current feedback/check evidence needed to establish workflow state;
2. identify which items already have a durable disposition and which require substantive evaluation, correction, clarification, evidence, or decision;
3. route substantive evaluation to the appropriate review/domain executor;
4. route confirmed correction work to the appropriate implementation/execution capability;
5. route decision needs to the authorized decision-maker;
6. respond on the existing GitHub surface when useful/expected and authorized;
7. update `Current State`/`Validation` only when the resulting execution state materially changes;
8. re-check current checks and unresolved in-scope feedback, then route to `resume`, `review`, discussion, blocker/handoff, or the next authorized finalizing action as appropriate.

The ledger may classify workflow state such as `needs substantive evaluation`, `confirmed correction`, `decision required`, or `blocked`. It must not manufacture a contested technical/product disposition merely to advance the lifecycle.

Approving, requesting changes, resolving threads, moving Draft to Ready, or merging all change GitHub state. Perform those actions only when user intent or repository delegation authorizes them.

This model deliberately avoids a generic input-state database or routine feedback-cycle checkpoints. Issues own task definition or initiative shaping, PR bodies own concrete PR execution state, comments/reviews provide durable input or feedback on those objects, commits/checks provide implementation and validation evidence, and substantive executors own the judgments/results appropriate to their capabilities.

## 11. Blockers and handoff

A blocker is work-control state even when resolving the blocker requires substantive expertise.

Record on the canonical surface when one exists:

- the blocker;
- the unblock condition;
- validation impact when applicable;
- remaining independently useful work;
- the substantive executor/decision-maker needed when known;
- the exact next action.

If diagnosing or resolving the blocker requires technical, product, design, or domain work, route that outcome rather than absorbing it into ledger policy.

For a handoff, make the canonical surface sufficient to resume without prior chat: current durable state, blockers/constraints, validation evidence, material decisions, pending substantive outcomes, and exact next action.

## 12. Completion

For executable Issue-backed repository work, prefer closing linked Issues by merging a PR with one or more `Closes #N`, `Fixes #N`, or `Resolves #N` links. Before treating the work as complete, reconcile the Issue's acceptance criteria against the delivered result; unchecked or stale criteria are not implicitly completed by the existence of the repository change. When this reconciliation requires substantive technical/product evaluation, obtain that outcome from the appropriate evaluator rather than inferring it from ledger state.

If the Issue declared a durable `Contract Impact` and names a source already designated by the user or established project policy, ensure the required substantive contract update was performed and the PR's `Contract Reconciliation` names it. If a substantive executor established that durable behavior changed but no source is designated, use `No contract source designated.` rather than creating one through the ledger workflow.

For exploratory initiatives, decomposition or delivery of one child does not by itself imply completion. Close the parent when its durable product/problem acceptance has been satisfied or the initiative is explicitly abandoned/superseded according to repository practice. Any substantive acceptance judgment must come from the appropriate evaluator or authorized decision-maker.

For standalone maintenance, the merged PR is the complete durable record; do not create or close an Issue solely for bookkeeping.

Every merged PR should be enough for a future reader to understand what was done, what evidence was produced, and how any durable contract obligation was reconciled. Limitations or follow-up work should be recorded only when they actually exist.

## 13. Recommended Project configuration

The only default field is:

- `Status`: Inbox / Ready / In Progress / Blocked / Review / Done

Add other fields only when the project genuinely benefits from maintaining them, for example `Priority` or `Iteration`. Prefer stable labels such as `type:*` or `area:*` over duplicating the same classification in Project fields.

Do not add a detailed discovery/design status machine merely to represent initiative shaping. The canonical Issue should carry the semantic distinction between candidate and accepted direction; Project fields remain a portfolio view rather than a second decision store.

Keep Project automation conservative. The workflow should make the normal path cheap and reserve extra bookkeeping for actual needs.

## 14. Operational Skill and context loading

[`../skills/agent-work-ledger/SKILL.md`](../skills/agent-work-ledger/SKILL.md) is the authoritative reusable work-control workflow for compatible Agent Skills runtimes.

The separation is intentional:

- `SKILL.md` owns the responsibility boundary, shared workflow invariants, progressive recovery/context-expansion policy, lifecycle routing, and authority boundaries once explicitly invoked.
- `SKILL.md` frontmatter carries portable user-invocation controls for runtimes that support them; `skills/agent-work-ledger/agents/openai.yaml` carries the OpenAI/Codex implicit-invocation policy.
- `skills/agent-work-ledger/references/` contains path-specific coordination deltas; load exactly one unless the operation changes.
- substantive project executors/capabilities produce design, specification, decomposition, implementation, validation-strategy, investigation, review, or other specialist outcomes when required;
- GitHub tools / APIs provide live Issue, PR, repository, check, and feedback state;
- the governance Action enforces only the small subset of the workflow policy that is deterministic and machine-checkable;
- this workflow document is detailed reference material, not a routine agent prompt dependency.

The retrieval model is deliberately trigger-based:

```text
canonical work surface
  -> relevant task/initiative definition
  -> designated contract context when materially constraining
  -> selected repository/check/feedback evidence needed for routing or executor context
  -> history only on discrepancy
```

The Skill should not cache task state, mechanically infer semantic readiness, preload evidence for later filtering, or take substantive ownership merely because a required outcome is currently missing. Once invoked, it applies its shared protocol, selects the operation and lifecycle reference, expands evidence according to its recovery budget, routes substantive work when needed, and persists the resulting durable state.
