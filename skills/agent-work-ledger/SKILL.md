---
name: agent-work-ledger
description: GitHub work ledger workflow for exploring/shaping initiatives, starting/resuming Issue-backed or standalone PR work, handling blockers/handoffs, preparing for review, or reviewing PRs using durable GitHub state.
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
| Explore/shape an initiative whose direction or decomposition is not stable | `references/shape.md` |
| Start repository or Issue-only executable work | `references/start.md` |
| Continue/resume active executable work | `references/resume.md` |
| Blocker or handoff | `references/blocker-handoff.md` |
| Prepare Draft PR for review | `references/ready.md` |
| Review PR | `references/review.md` |

Do not route exploratory initiative work through executable `start`/`resume` merely because it has a next step. A next question, evidence-gathering step, or candidate direction does not by itself create an implementation contract.

## Execution boundary

After routing, follow the recovery budget in `AGENTS.md` and gather only evidence required by the selected reference. Infer tracking mode from canonical state, take the smallest safe next action, and update canonical state only when it materially changes.

Shaping permits investigation, durable conclusions, explicit decisions, and decomposition within user authority; it does not permit treating speculative directions as implementation requirements. Implementation/resume permits normal executable work-item changes within user authority. Review is read-only unless fixes are separately requested. Draft-to-Ready, merge/close, accepted-direction decisions that exceed delegated authority, and other finalizing actions require explicit user intent or clear repository delegation.

Stop or switch paths when required tracking context is absent, a shaping decision requires unavailable authority, executable requirements remain materially ambiguous, a dependency or approval is unavailable, readiness policy blocks transition, or the requested action exceeds authority. For recoverable stops, leave the canonical surface with the blocker and exact next action or uncertainty-reducing question.
