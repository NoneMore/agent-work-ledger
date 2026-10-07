---
name: agent-work-ledger
description: GitHub work ledger workflow for starting/resuming Issue-backed or standalone PR work, handling blockers/handoffs, preparing for review, reviewing PRs, or handling PR feedback using durable GitHub state.
disable-model-invocation: true
user-invocable: true
---

# Agent Work Ledger

Read the applicable `AGENTS.md` first; it is authoritative. This Skill selects the lifecycle operation and its behavioral boundary. Do not restate workspace policy in lifecycle references.

Do not read `docs/AGENT_WORKFLOW.md` on the normal path. Use it only when changing the workflow, resolving policy ambiguity, or when `AGENTS.md` plus the selected reference are insufficient.

## Route first

Load exactly one lifecycle reference. Switch only if the operation changes.

| Operation | Reference |
| --- | --- |
| Start repository or Issue-only work | `references/start.md` |
| Continue/resume active work | `references/resume.md` |
| Blocker or handoff | `references/blocker-handoff.md` |
| Prepare Draft PR for review | `references/ready.md` |
| Review PR | `references/review.md` |
| Handle PR feedback | `references/feedback.md` |

Inbound GitHub surfaces do not add lifecycle routes. An existing Issue enters `start` or `resume` according to whether execution has begun; an existing PR is already an execution surface and routes by the requested operation rather than by authorship. Issue comments remain input to the active Issue-backed path unless their effect requires a blocker/handoff or another existing route. PR conversation comments, submitted reviews, and review threads route to `feedback` when they become active work.

## Execution boundary

After routing, follow the recovery budget in `AGENTS.md` and gather only evidence required by the selected reference. Infer tracking mode from canonical state, take the smallest safe next action, and update canonical state only when it materially changes.

Implementation/resume and authorized PR-feedback handling permit normal work-item changes within user authority. Review is optional unless repository policy or explicit user intent requires it, and is read-only by default. Actionable findings from review or existing PR feedback route through `feedback`; after feedback handling, a Draft PR may return to `ready`, while an already non-Draft PR returns to review only when policy or user intent requires another review. Draft-to-Ready, merge/close, and other finalizing actions require explicit user intent or clear repository delegation.

Stop or switch paths when required tracking context is absent, requirements remain materially ambiguous, a dependency or approval is unavailable, readiness policy blocks transition, or the requested action exceeds authority. For recoverable stops, leave the canonical surface with the blocker and exact next action.
