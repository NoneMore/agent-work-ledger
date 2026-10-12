# Establish durable work state

Use when the work does not yet have the canonical durable surface it needs.

1. Determine whether the work needs an independent Issue lifecycle. Problems/requests, initiatives, multi-PR work, durable discussion/acceptance, and pre-PR work that must be resumable normally do. Routine maintenance may stay PR-only.
2. Reuse existing Issues/PRs when they already represent the work. Do not create parallel tracking.
3. For Issue-backed executable work, recover the established objective/acceptance criteria and relevant constraints. If tracking can be established while a substantive prerequisite remains unknown, record that prerequisite instead of forcing clarification.
4. Create the branch when authorized and useful. Use `agent/<issue-number>-<slug>` for Issue-backed work and `agent/maintenance-<slug>` for standalone maintenance.
5. Do not create a synthetic commit. After a first meaningful repository commit exists, open/adopt a Draft PR and initialize the canonical PR snapshot from evidence.
6. For non-repository work, keep durable state on the Issue rather than creating an artificial PR.
7. If standalone work must stop before a PR exists and durable resumption is required, create/adopt an Issue when authorized; otherwise state that durable tracking is still missing.

Done when the appropriate canonical surface exists and reflects established state, or the missing prerequisite to establish it is explicit.
