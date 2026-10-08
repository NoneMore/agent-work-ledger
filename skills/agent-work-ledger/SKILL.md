---
name: agent-work-ledger
description: GitHub work ledger workflow for exploring/shaping initiatives, starting/resuming executable work, blockers/handoffs, PR review, and PR feedback.
disable-model-invocation: true
user-invocable: true
---

# Agent Work Ledger

Read the applicable `AGENTS.md` first; it is authoritative. This Skill only routes the current operation and adds operation-specific boundaries. Do not load `docs/AGENT_WORKFLOW.md` normally; use it for workflow changes or unresolved policy ambiguity.

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

After routing, apply the `AGENTS.md` recovery budget and selected reference only. Review is read-only by default; authorized feedback handling may write only within its reference boundary. Finalizing GitHub transitions require the authority defined in `AGENTS.md`.

Stop or switch paths when required tracking context is missing, executable requirements remain materially ambiguous, a dependency/approval blocks work, or the requested action exceeds authority. Untracked shaping is not missing tracking context merely because no Initiative Issue exists; create or adopt one only when durable tracking becomes explicitly required or repository policy requires it. Leave recoverable blockers and the exact next action on the canonical surface when one exists.
