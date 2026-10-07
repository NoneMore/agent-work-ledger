---
name: agent-work-ledger
description: GitHub work ledger workflow for starting/resuming Issue-backed or standalone PR work, handling blockers/handoffs, preparing for review, or reviewing PRs using durable GitHub state.
disable-model-invocation: true
user-invocable: true
---

# Agent Work Ledger

Read the applicable `AGENTS.md` first; it is authoritative. This Skill only selects an operation and its minimum evidence. Do not restate policy from `AGENTS.md` in lifecycle references.

Do not read `docs/AGENT_WORKFLOW.md` on the normal path. Use it only when changing the workflow, resolving policy ambiguity, or when `AGENTS.md` plus the selected reference are insufficient.

## Route first

Load exactly one lifecycle reference. Load another only if the operation changes.

| Operation | Reference |
| --- | --- |
| Start repository or Issue-only work | `references/start.md` |
| Continue/resume active work | `references/resume.md` |
| Blocker or handoff | `references/blocker-handoff.md` |
| Prepare Draft PR for review | `references/ready.md` |
| Review PR | `references/review.md` |

## Context budget

Start with the canonical execution surface: PR metadata/body when a PR exists, otherwise the Issue execution state. Then expand only on a concrete trigger:

- **Issue-backed scope/completion work:** for start, resume, ready, or review, read the linked Issue objective/acceptance criteria; skip Issue comments/history unless a discrepancy requires them.
- **Repository evidence needed:** changed filenames/stats -> selected patches -> surrounding source only where the patch is insufficient.
- **Validation needed:** check summary -> failed job -> failed step/log slice. Do not preload complete CI logs.
- **Review feedback needed:** unresolved actionable threads -> referenced patch/source. Skip resolved/history by default.
- **Current state is inconsistent:** only then read historical Issue/PR discussion needed to explain it.

Never use “load everything, then filter.” A full PR diff is acceptable only when demonstrably small and wholly relevant.

## Execution contract

Infer the operation and tracking mode from user intent plus canonical state, take the smallest safe next action, and update only canonical state when it materially changes. Repository evidence overrides stale prose. Persist conclusions/evidence/decisions, not private chain-of-thought.

Implementation/resume permits normal work-item changes within user authority. Review is read-only unless fixes are separately requested. Draft-to-Ready, merge/close, and other finalizing actions require explicit user intent or clear repository delegation.

Stop or switch paths when required tracking context is absent, requirements remain materially ambiguous, a dependency/approval is unavailable, readiness policy blocks transition, or the requested action exceeds authority. For recoverable stops, leave the canonical surface with the blocker and exact next action.
