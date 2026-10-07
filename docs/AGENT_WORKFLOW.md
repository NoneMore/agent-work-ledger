# GitHub-native Agent Workflow

This repository uses GitHub Issues and Pull Requests as a durable work ledger without turning routine execution into paperwork.

This document is the detailed human/reference description of the workflow. Agents should not load it on the normal execution path: `AGENTS.md` carries workspace-wide invariants, while an explicitly invoked `skills/agent-work-ledger/SKILL.md` routes to one small lifecycle reference. Consult this document when changing the workflow, resolving policy ambiguity, or when a repository-specific detail is not covered by those smaller surfaces.

## 1. System of record

Each GitHub surface has one primary responsibility:

| Surface | Role |
| --- | --- |
| Issue | Defines problems, requests, and other work worth tracking independently |
| Issue comments | Durable discussion and input around Issue-defined work |
| Draft / open PR | Current repository execution snapshot and implementation artifact |
| PR conversation comments / reviews | Durable feedback on PR-backed work |
| Commits / checks | Implementation and validation evidence |
| GitHub Project | Cross-task progress view |

Avoid maintaining the same status in multiple places. Once a PR exists, execution state belongs in the PR body rather than being duplicated into an Issue or comments.

The ledger has four inbound GitHub shapes that matter to lifecycle handling: a new Issue, an Issue comment, an existing/new PR, and PR feedback through conversation comments or review surfaces. They do not form a separate generic `external input` lifecycle. The surface gives the input its default role; its effect determines whether task definition, execution state, feedback disposition, blocker state, or authority actually changes.

Authorship does not change those roles. An externally opened Issue or PR is adopted through the same lifecycle rather than recreated. Checks are evidence, Project fields are portfolio/coordination metadata, and direct user instructions provide intent, authority, or context; none is a fifth GitHub ledger input surface.

An Issue and a PR are not required to exist 1:1. Issues represent public work items; PRs represent repository changes.

## 2. Normal lifecycles

Issue-backed work:

```text
Issue
  -> branch
  -> first meaningful commit
  -> Draft PR
  -> work
  -> validation
  -> Ready for Review
  -> [review when required or requested]
  -> [PR feedback when present -> handle feedback]
  -> merge
  -> Issue closed
```

Standalone repository maintenance:

```text
branch
  -> first meaningful commit
  -> Draft PR
  -> work
  -> validation
  -> Ready for Review
  -> [review when required or requested]
  -> [PR feedback when present -> handle feedback]
  -> merge
```

Review is an available operation, not a mandatory lifecycle stage. It is required only when repository policy or explicit user intent requires it. The bracketed review and feedback steps are optional and may repeat. PR feedback can also arrive before or without formal review, at any point after the PR exists. Handling feedback does not imply a code fix: the correct outcome may be a reply, clarification, evidence-based no-change disposition, correction, blocker, or decision request. After feedback handling, continue to the next operation required by policy or intent: review, continued discussion, or readiness for a separately authorized merge.

The first meaningful commit gives GitHub something to compare against the base branch before the Draft PR is opened.

For work that does not produce repository changes but is worth tracking, keep execution state on the Issue instead of creating an artificial PR.

## 3. Issue intake

Create an Issue when the work should exist independently of any particular PR. Typical cases include:

- externally reported problems or user-visible bugs,
- feature requests or product/documentation requests,
- work requiring discussion, prioritization, coordination, or explicit acceptance criteria before implementation,
- efforts likely to span multiple PRs,
- migrations, risks, or follow-ups worth tracking even if no PR exists yet.

The decisive test is whether the work needs a lifecycle independent of the current PR: separate prioritization, discussion, acceptance, continuation across multiple PRs, or durable follow-up after the current change. Category examples are heuristics, not exemptions.

Do not create a synthetic Issue merely because repository files will change. Dependency maintenance, CI/build/release work, internal refactors, tests, documentation upkeep, developer tooling, formatting, and repository metadata may start directly from a PR when the PR itself is a sufficient public record.

This distinction is about **tracking value**, not change risk or size. A high-risk maintenance PR may still be PR-only and require strong review/validation; a small user request may still deserve an Issue because it belongs in the public work queue.

If standalone maintenance develops independent tracking value after work starts, promote it to Issue-backed work: create an Issue, replace the standalone declaration in `## Tracking` with `Closes #N`, `Fixes #N`, or `Resolves #N`, and continue from the existing PR. Do not rename the existing branch solely to reflect this transition. Branch naming records how work started; `## Tracking` and the linked Issue are canonical for how it is tracked now.

A normal executable Issue should answer four questions:

1. **Objective** — what durable outcome is required?
2. **Acceptance Criteria** — how do we know it is done?
3. **Context** — what information or references are needed to execute safely?
4. **Constraints** — what boundaries or non-goals matter?

Only Objective and Acceptance Criteria are required by the Issue Form. Context, constraints, and dependencies are optional because not every task needs them. Prefer paths, links, and durable decisions over copying large reference material into the Issue.

Issue comments may clarify, constrain, or make decisions about the work, but they do not become a second task-definition store. When a current comment materially changes the objective, acceptance criteria, constraints, blocker, or Issue-only execution state, reflect the resulting durable state in the Issue during authorized write work. Keep the comment as provenance/history; do not copy it verbatim just for bookkeeping.

Once repository execution moves into a PR, do not maintain `Current State` or `Next Action` on the Issue. The Issue remains the task definition.

## 4. Execution

For all repository changes that do not already have a PR execution surface:

1. Choose the initial tracking path before creating the branch.
2. For Issue-backed work, normally create `agent/<issue-number>-<slug>` and later link the PR with `Closes #N`, `Fixes #N`, or `Resolves #N` in `## Tracking`.
3. For standalone maintenance, normally create `agent/maintenance-<slug>` and later declare `Standalone maintenance: <brief reason or scope>` in `## Tracking`.
4. Make the first meaningful commit.
5. Open a Draft PR and use its body as the single execution snapshot.
6. Update the PR body when execution state materially changes, including promotion from standalone to Issue-backed tracking.
7. Record validation before marking the PR ready for review.

If work arrives as an existing PR, do not recreate its branch or PR merely to fit the normal creation sequence. Treat that PR as the execution artifact, infer or establish the correct tracking mode, and normalize the minimum PR contract during authorized write work. If write authority is unavailable, report the missing contract rather than creating a parallel ledger.

Branch naming is a creation convention and is not used to infer current tracking mode. The `## Tracking` section is the canonical machine-readable tracking declaration.

The minimum PR snapshot is:

```markdown
## Tracking

Closes #123
<!-- OR: Standalone maintenance: explain briefly why no separate Issue is useful. -->

## Current State

What is done, what remains, and the exact next action if unfinished.

## Validation

Tests / checks run and their results. Note anything important not run and why.

## Notes

Optional: limitations, risks, follow-ups, material decisions, or review focus.
```

Choose exactly one tracking mode in `## Tracking`; Issue-backed mode may contain one or more closing links. Governance reads tracking declarations only from that section; examples or historical text elsewhere in the PR body do not change the tracking mode. `Notes` are optional. Delete the section when it adds no value. Keep the snapshot about the work itself; do not restate repository policy or closing-linked Issue acceptance criteria unless needed to explain current state.

## 5. Comments are for exceptions

Do **not** post routine claim or progress checkpoints.

For Issue-backed work, Issue comments are durable discussion/input around the Issue. Material changes to task definition or Issue-only execution state should be reflected in the Issue when authorized so later recovery does not depend on replaying comment history.

The PR body always owns PR-backed execution status. If work becomes blocked, update `Current State` there. Add a comment only when the blocker also needs notification, explanation, discussion, or durable historical context.

Other reasons to leave a comment include a material decision changing implementation direction, an important discovery invalidating earlier assumptions, a direct response to PR feedback, or a pause where the canonical execution surface alone is insufficient for safe resumption.

Review threads, submitted reviews, and PR conversation comments are durable feedback sources, not a replacement execution-state store. Do not copy feedback already present on GitHub into `Current State` merely to create another ledger. Update canonical PR state only when handling the feedback materially changes execution state. Respond on the existing GitHub feedback surface when communication or disposition belongs there.

Comments preserve useful communication, input, and history; they do not become a second current-state store.

## 6. Recovery after interruption

Recovery is canonical-first and trigger-based. The goal is to load only enough context to determine the next safe action.

1. If a PR exists, read its metadata/body first. For Issue-only work, read the Issue execution state.
2. Use `## Tracking` to identify the tracking source. For Issue-backed work, read every closing-linked Issue's objective/acceptance criteria whenever the selected operation will continue implementation or judge intended scope/completion. Inspect relevant current Issue comments only when they may materially change task definition, a decision, blocker, or Issue-only execution state; do not preload full Issue history. For standalone work, use the PR title/body as the task definition.
3. When repository behavior matters, read changed filenames/stats, then selected patches, then surrounding source only where needed.
4. Read check summaries only when validation affects the current operation; expand failed jobs/steps only for diagnosis. Read current PR feedback — unresolved review threads, relevant submitted reviews or PR conversation comments, and feedback-related blockers in canonical current state — only when relevant to the selected operation.
5. Read older or resolved Issue/PR discussion only if current canonical state and current input/evidence cannot explain a material decision or discrepancy.

Do not use a full PR diff, complete CI logs, linked-Issue history, or full review/comment history as default recovery shortcuts. Small complete diffs are acceptable when demonstrably small and wholly relevant.

Repository facts win over stale prose. Correct stale canonical state during authorized write work, or report the mismatch during read-only review.

## 7. Ready for Review

Before moving a PR out of Draft:

- exactly one tracking mode is explicit in `## Tracking`: Issue-backed or standalone maintenance,
- the selected tracking mode still fits the work; promote standalone work first if it has developed independent tracking value,
- every closing-linked Issue's acceptance criteria are satisfied or incomplete items are explicit for Issue-backed work,
- `Current State` accurately represents the work, including any material feedback blocker that changes execution state,
- appropriate validation is recorded,
- PR feedback blocks readiness only when it remains actionable and material to intended scope or repository policy,
- an exact next action is present if work is intentionally incomplete,
- optional limitations, risks, follow-ups, or review focus are recorded only when useful.

The readiness path is for Draft PRs. An already non-Draft PR returning from feedback handling continues to the next operation required by repository policy or user intent — review, continued discussion, or readiness for a separately authorized merge — after its state and validation are refreshed; it does not cycle through Draft readiness again.

The governance workflow checks only the minimum structural contract: `## Tracking` must contain either an Issue closing link or an explicit standalone-maintenance declaration, plus `Current State` and `Validation`. Tracking-like text outside `## Tracking` is ignored. The workflow intentionally does not require routine progress logging or boilerplate handoff sections.

The versioned repository ruleset at [`.github/rulesets/main.json`](../.github/rulesets/main.json) is the enforcement counterpart for `main`: when applied in GitHub, it requires changes to go through a Pull Request and requires the `Validate Issue linkage and resumability` status check before merge. The check name is retained for live-ruleset compatibility even though the check now accepts both tracking modes. Committing the JSON does not activate repository settings by itself; an administrator must import or apply the ruleset, and the live ruleset should remain aligned with the versioned file.

## 8. Review and PR feedback

Review and feedback handling are separate operations with different authority boundaries. Review is an available operation, not a mandatory lifecycle stage; require it only when repository policy or explicit user intent does.

A review is read-only by default. Establish intended scope, inspect the smallest sufficient repository/check/feedback evidence, and report only actionable findings. A finding produced by that read-only review is review output until the user explicitly asks to act on it; do not mutate GitHub merely to make the finding durable.

GitHub-native PR feedback comes from inline review threads, submitted reviews, and top-level PR conversation comments. Existing GitHub feedback is already durable and remains its own source; do not mirror it into the PR body solely for bookkeeping. A review finding may enter the same feedback-handling path once action is authorized, but that transition does not create another inbound GitHub surface.

When feedback handling is authorized, route it through the feedback lifecycle rather than generic resume:

1. Recover canonical PR state, the task definition when required, current check summaries when relevant, and only the current feedback needed for the operation.
2. Classify each in-scope item before acting: question/discussion, actionable change, evidence-based no-change disposition, or blocker/decision.
3. Respond on the existing GitHub surface when a response is useful or expected. For an actionable change, make the minimum correction and run validation appropriate to it. For a no-change disposition, provide concrete evidence. For a blocker or required decision, make the unblock condition and exact next action durable.
4. Update `Current State` / `Validation` only when execution state materially changes. Do not create a synthetic feedback ledger for review findings or direct user instructions; persist only resulting material execution state when needed for resumability.
5. Re-check current checks and unresolved in-scope feedback after changes or replies. Resolve a review thread only after its concern is corrected or explicitly dispositioned and only with authority. Return to review only when repository policy or explicit user intent requires it; continue discussion when a decision is still pending; otherwise leave the PR ready for a separately authorized merge.

Approving, requesting changes, resolving threads, moving Draft to Ready, or merging all change GitHub state. Perform those actions only when user intent or repository delegation authorizes them.

This model deliberately avoids a generic input-state database or routine feedback-cycle checkpoints. Issues own task definition, PR bodies own PR execution state, comments/reviews provide durable input or feedback on those objects, and commits/checks provide implementation and validation evidence.

## 9. Completion

For Issue-backed repository work, prefer closing linked Issues by merging a PR with one or more `Closes #N`, `Fixes #N`, or `Resolves #N` links.

For standalone maintenance, the merged PR is the complete durable record; do not create or close an Issue solely for bookkeeping.

Every merged PR should be enough for a future reader to understand what was done and how it was validated. Limitations or follow-up work should be recorded only when they actually exist.

## 10. Recommended Project configuration

The only default field is:

- `Status`: Inbox / Ready / In Progress / Blocked / Review / Done

Add other fields only when the project genuinely benefits from maintaining them, for example `Priority` or `Iteration`. Prefer stable labels such as `type:*` or `area:*` over duplicating the same classification in Project fields.

Keep Project automation conservative. The workflow should make the normal path cheap and reserve extra bookkeeping for actual needs.

## 11. Operational Skill and context loading

[`../skills/agent-work-ledger/SKILL.md`](../skills/agent-work-ledger/SKILL.md) is the reusable execution layer for compatible Agent Skills runtimes.

The separation is intentional:

- `AGENTS.md` owns workspace-wide invariants and the progressive recovery/context-expansion policy.
- `SKILL.md` owns lifecycle routing plus behavioral, authority, and stop boundaries once the Skill is explicitly invoked.
- `SKILL.md` frontmatter carries portable user-invocation controls for runtimes that support them; `skills/agent-work-ledger/agents/openai.yaml` carries the OpenAI/Codex implicit-invocation policy.
- `skills/agent-work-ledger/references/` contains only path-specific action deltas; load exactly one unless the operation changes.
- GitHub tools / APIs provide live Issue, PR, repository, check, and feedback state.
- The governance Action enforces the small subset of the contract that is deterministic and machine-checkable.
- This workflow document is detailed reference material, not a routine agent prompt dependency.

The retrieval model is deliberately trigger-based:

```text
canonical execution surface
  -> closing-linked Issue task definitions for Issue-backed scope/completion work
  -> selected current input/repository/check/feedback evidence only when needed
  -> history only on discrepancy
```

The Skill should not cache task state, restate `AGENTS.md`, or preload evidence for later filtering. Once invoked, it selects the operation and lifecycle reference; evidence then expands according to the `AGENTS.md` recovery budget when the current operation has a concrete evidence need.