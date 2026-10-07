# GitHub-native Agent Workflow

This repository uses GitHub Issues and Pull Requests as a durable work ledger without turning routine execution into paperwork.

This document is the detailed human/reference description of the workflow. Agents should not load it on the normal execution path: `AGENTS.md` carries workspace-wide invariants, while an explicitly invoked `skills/agent-work-ledger/SKILL.md` routes to one small lifecycle reference. Consult this document when changing the workflow, resolving policy ambiguity, or when a repository-specific detail is not covered by those smaller surfaces.

## 1. System of record

Each GitHub surface has one primary responsibility:

| Surface | Role |
| --- | --- |
| Issue | Defines problems, requests, exploratory initiatives, and executable work worth tracking independently |
| Draft / open PR | Current repository execution snapshot and implementation artifact |
| Issue / PR comments | Exception-only communication and history |
| Commits / checks | Implementation and validation evidence |
| GitHub Project | Cross-task progress view |

Avoid maintaining the same status in multiple places. Once an executable repository change has a PR, execution state belongs in the PR body rather than being duplicated into an Issue or comments. Exploratory initiative state remains on the parent Issue because that Issue owns the durable problem/decision lifecycle rather than a particular repository change.

An Issue and a PR are not required to exist 1:1. Issues represent independently tracked work or initiatives; PRs represent repository changes.

## 2. Normal lifecycles

Executable Issue-backed work:

```text
Issue
  -> branch
  -> first meaningful commit
  -> Draft PR
  -> work
  -> validation
  -> Ready for Review
  -> review / fixes
  -> merge
  -> Issue closed
```

Exploratory initiative work is different. It may loop as evidence changes and does not become executable merely because it has a next step:

```text
Initiative Issue
  -> investigate / frame / compare alternatives
  -> explicit accepted direction when authorized
  -> decompose into executable child Issues when useful
  -> child delivery / validation
  -> parent product or problem acceptance
  -> Initiative closed
```

An accepted direction can be reopened by contradictory evidence. The workflow does not define a mechanical readiness score or require every unknown to disappear before downstream work begins; the important boundary is whether a direction has been explicitly accepted and is safe for downstream work to rely on.

Standalone repository maintenance:

```text
branch
  -> first meaningful commit
  -> Draft PR
  -> work
  -> validation
  -> Ready for Review
  -> review / fixes
  -> merge
```

The first meaningful commit gives GitHub something to compare against the base branch before the Draft PR is opened.

For work that does not produce repository changes but is worth tracking, keep execution or shaping state on the Issue instead of creating an artificial PR.

## 3. Issue intake

Create an Issue when the work should exist independently of any particular PR. Typical cases include:

- externally reported problems or user-visible bugs,
- feature requests or product/documentation requests,
- work requiring discussion, prioritization, coordination, investigation, or explicit acceptance criteria before implementation,
- efforts likely to span multiple PRs or independently executable child Issues,
- migrations, risks, or follow-ups worth tracking even if no PR exists yet.

The decisive test is whether the work needs a lifecycle independent of the current PR: separate prioritization, discussion, exploration, acceptance, continuation across multiple PRs, or durable follow-up after the current change. Category examples are heuristics, not exemptions.

Do not create a synthetic Issue merely because repository files will change. Dependency maintenance, CI/build/release work, internal refactors, tests, documentation upkeep, developer tooling, formatting, and repository metadata may start directly from a PR when the PR itself is a sufficient public record.

This distinction is about **tracking value**, not change risk or size. A high-risk maintenance PR may still be PR-only and require strong review/validation; a small user request may still deserve an Issue because it belongs in the public work queue.

If standalone maintenance develops independent tracking value after work starts, promote it to Issue-backed work: create an Issue, replace the standalone declaration in `## Tracking` with `Closes #N`, `Fixes #N`, or `Resolves #N`, and continue from the existing PR. Do not rename the existing branch solely to reflect this transition. Branch naming records how work started; `## Tracking` and the linked Issue are canonical for how it is tracked now.

### Executable Issues

An executable Issue should answer four questions:

1. **Objective** — what durable outcome is required?
2. **Acceptance Criteria** — how do we know it is done?
3. **Context** — what information or references are needed to execute safely?
4. **Constraints** — what boundaries or non-goals matter?

Only Objective and Acceptance Criteria are required by the current Agent Task Issue Form. Context, constraints, and dependencies are optional because not every task needs them. Prefer paths, links, and durable decisions over copying large reference material into the Issue.

Once repository execution for that deliverable moves into a PR, do not maintain `Current State` or `Next Action` on the executable Issue. The Issue remains the task definition.

### Exploratory initiatives

Use an exploratory initiative when the durable problem, product outcome, or acceptance lifecycle is worth tracking but the solution, accepted direction, or executable decomposition is not yet stable. Do not force this work into a premature Objective/Acceptance Criteria contract just to make it look executable.

The initiative should preserve only durable state useful to the next executor or decision-maker, for example:

- the problem or opportunity being explored,
- current understanding and material evidence,
- open questions or uncertainties that still matter,
- candidate directions, clearly distinguished from accepted decisions,
- an explicitly accepted direction when authority has made that decision,
- the smallest next investigation, decision, or decomposition step,
- executable child work and the parent-level acceptance that remains after decomposition.

These are semantic responsibilities, not a required heading schema. An initiative may explicitly state that no direction is accepted yet. Detail alone does not imply commitment: a polished proposal, prototype, or extensive research result remains a candidate until an authorized decision accepts it.

Commitment is a decision, not a readiness test. It is reasonable to accept a direction while execution-local unknowns remain, provided those unknowns do not invalidate the decision being relied upon. When contradictory evidence does invalidate an accepted direction, reopen that decision explicitly and reassess affected downstream work instead of silently changing the contract.

Decomposition also does not complete the parent initiative. Child Issues should be independently executable and reviewable, while the parent may remain open as the durable product/problem acceptance surface across multiple deliveries.

When exploratory research or design itself requires repository changes before the parent should close, give that concrete repository-changing slice its own executable Issue/PR surface. Do not use a closing link to the parent initiative when merging the slice would not actually complete the parent lifecycle.

## 4. Execution

For executable repository changes:

1. Choose the initial tracking path before creating the branch.
2. For Issue-backed work, normally create `agent/<issue-number>-<slug>` and later link the PR with `Closes #N`, `Fixes #N`, or `Resolves #N` in `## Tracking`.
3. For standalone maintenance, normally create `agent/maintenance-<slug>` and later declare `Standalone maintenance: <brief reason or scope>` in `## Tracking`.
4. Make the first meaningful commit.
5. Open a Draft PR and use its body as the single execution snapshot.
6. Update the PR body when execution state materially changes, including promotion from standalone to Issue-backed tracking.
7. Record validation before marking the PR ready for review.

Branch naming is a creation convention and is not used to infer current tracking mode. The `## Tracking` section is the canonical machine-readable tracking declaration.

The minimum PR snapshot is:

```markdown
## Tracking

Closes #123
<!-- OR: Standalone maintenance: explain briefly why no separate Issue is useful. -->

## Current State

What is done, what remains, and the exact next action or uncertainty-reducing question if unfinished.

## Validation

Tests / checks run and their results. Note anything important not run and why.

## Notes

Optional: limitations, risks, follow-ups, material decisions, or review focus.
```

Choose exactly one tracking mode in `## Tracking`; Issue-backed mode may contain one or more closing links. Governance reads tracking declarations only from that section; examples or historical text elsewhere in the PR body do not change the tracking mode. `Notes` are optional. Delete the section when it adds no value. Keep the snapshot about the work itself; do not restate repository policy or closing-linked Issue acceptance criteria unless needed to explain current state.

A repository-changing exploratory slice follows the same PR execution contract once it has been cut into a concrete executable unit. The parent initiative continues to own shaping and parent-level acceptance rather than duplicating the child PR's execution state.

## 5. Comments are for exceptions

Do **not** post routine claim or progress checkpoints.

The PR body always owns current execution status for repository-changing executable work. If work becomes blocked, update `Current State` there. Add a comment only when the blocker also needs notification, explanation, discussion, or durable historical context.

For exploratory initiatives, keep current understanding and decision state on the Issue body rather than spreading routine shaping state through comments. Comments remain appropriate when notification or historical context is useful beyond the current canonical state.

Other reasons to leave a comment include a material decision changing implementation direction, an important discovery invalidating earlier assumptions, or a pause where the canonical execution surface alone is insufficient for safe resumption.

Comments preserve useful history; they do not become a second current-state store.

## 6. Recovery after interruption

Recovery is canonical-first and trigger-based. The goal is to load only enough context to determine the next safe action.

1. If an executable PR exists, read its metadata/body first. For Issue-only executable or exploratory work, read the Issue canonical state.
2. For executable Issue-backed implementation or completion judgments, use `## Tracking` to identify every closing-linked Issue and read its objective/acceptance criteria; do not preload Issue comments/history. For exploratory initiative work, recover the durable problem/current understanding, explicit accepted decisions if any, material open questions, and the next uncertainty-reducing step. For standalone work, use the PR title/body as the task definition.
3. When repository behavior matters, read changed filenames/stats, then selected patches, then surrounding source only where needed.
4. Read check summaries only when validation affects the current operation; expand failed jobs/steps only for diagnosis. Read unresolved actionable review feedback only when relevant.
5. Read historical Issue/PR discussion only if current canonical state cannot explain a material decision or discrepancy.

Do not use a full PR diff, complete CI logs, linked-Issue history, or full review/comment history as default recovery shortcuts. Small complete diffs are acceptable when demonstrably small and wholly relevant.

Repository facts win over stale prose. Correct stale canonical state during authorized write work, or report the mismatch during read-only review.

## 7. Ready for Review

Before moving a PR out of Draft:

- exactly one tracking mode is explicit in `## Tracking`: Issue-backed or standalone maintenance,
- the selected tracking mode still fits the work; promote standalone work first if it has developed independent tracking value,
- every closing-linked executable Issue's acceptance criteria are satisfied or incomplete items are explicit for Issue-backed work,
- a closing link does not falsely imply completion of a parent initiative that still owns unresolved product/problem acceptance,
- `Current State` accurately represents the work,
- appropriate validation is recorded,
- an exact next action is present if work is intentionally incomplete,
- optional limitations, risks, follow-ups, or review focus are recorded only when useful.

The governance workflow checks only the minimum structural contract: `## Tracking` must contain either an Issue closing link or an explicit standalone-maintenance declaration, plus `Current State` and `Validation`. Tracking-like text outside `## Tracking` is ignored. The workflow intentionally does not attempt to decide whether an Issue is semantically ready, whether an accepted direction is correct, or whether routine progress has been logged.

The versioned repository ruleset at [`.github/rulesets/main.json`](../.github/rulesets/main.json) is the enforcement counterpart for `main`: when applied in GitHub, it requires changes to go through a Pull Request and requires the `Validate Issue linkage and resumability` status check before merge. The check name is retained for live-ruleset compatibility even though the check now accepts both tracking modes. Committing the JSON does not activate repository settings by itself; an administrator must import or apply the ruleset, and the live ruleset should remain aligned with the versioned file.

## 8. Completion

For executable Issue-backed repository work, prefer closing linked Issues by merging a PR with one or more `Closes #N`, `Fixes #N`, or `Resolves #N` links.

For exploratory initiatives, decomposition or delivery of one child does not by itself imply completion. Close the parent when its durable product/problem acceptance has been satisfied or the initiative is explicitly abandoned/superseded according to repository practice.

For standalone maintenance, the merged PR is the complete durable record; do not create or close an Issue solely for bookkeeping.

Every merged PR should be enough for a future reader to understand what was done and how it was validated. Limitations or follow-up work should be recorded only when they actually exist.

## 9. Recommended Project configuration

The only default field is:

- `Status`: Inbox / Ready / In Progress / Blocked / Review / Done

Add other fields only when the project genuinely benefits from maintaining them, for example `Priority` or `Iteration`. Prefer stable labels such as `type:*` or `area:*` over duplicating the same classification in Project fields.

Do not add a detailed discovery/design status machine merely to represent initiative shaping. The canonical Issue should carry the semantic distinction between candidate and accepted direction; Project fields remain a portfolio view rather than a second decision store.

Keep Project automation conservative. The workflow should make the normal path cheap and reserve extra bookkeeping for actual needs.

## 10. Operational Skill and context loading

[`../skills/agent-work-ledger/SKILL.md`](../skills/agent-work-ledger/SKILL.md) is the reusable execution layer for compatible Agent Skills runtimes.

The separation is intentional:

- `AGENTS.md` owns workspace-wide invariants and the progressive recovery/context-expansion policy.
- `SKILL.md` owns lifecycle routing plus behavioral, authority, and stop boundaries once the Skill is explicitly invoked.
- `SKILL.md` frontmatter carries portable user-invocation controls for runtimes that support them; `skills/agent-work-ledger/agents/openai.yaml` carries the OpenAI/Codex implicit-invocation policy.
- `skills/agent-work-ledger/references/` contains only path-specific action deltas; load exactly one unless the operation changes.
- GitHub tools / APIs provide live Issue, PR, repository, check, and review state.
- The governance Action enforces only the small subset of the contract that is deterministic and machine-checkable.
- This workflow document is detailed reference material, not a routine agent prompt dependency.

The retrieval model is deliberately trigger-based:

```text
canonical work surface
  -> exploratory initiative state when shaping
  -> closing-linked executable Issue task definitions for implementation/scope/completion work
  -> repository/check/review index only when needed
  -> selected evidence
  -> history only on discrepancy
```

The Skill should not cache task state, restate `AGENTS.md`, mechanically infer semantic readiness, or preload evidence for later filtering. Once invoked, it selects the operation and lifecycle reference; evidence then expands according to the `AGENTS.md` recovery budget when the current operation has a concrete evidence need.
