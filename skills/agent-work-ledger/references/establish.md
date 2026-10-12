# Establish durable work state

Use when the work does not yet have the canonical durable surface it needs.

1. Reuse an existing Issue/PR when it already represents the work. Otherwise use an Issue only when an independent lifecycle has durable value; routine maintenance may remain PR-only.
2. Recover enough established objective/acceptance/constraint state to create tracking. If a substantive prerequisite is still unknown, record it instead of forcing clarification when tracking can still be established safely.
3. Create a branch when authorized and useful: `agent/<issue-number>-<slug>` for Issue-backed work, `agent/maintenance-<slug>` for standalone maintenance.
4. Do not create a synthetic commit. After a first meaningful repository commit exists, open/adopt a Draft PR and initialize the canonical snapshot from evidence.
5. Keep non-repository work on the Issue. If standalone repository work must stop before a PR exists and durable resumption is required, create/adopt an Issue when authorized; otherwise leave durable tracking as the missing prerequisite.

Done when the appropriate canonical surface exists and reflects established state, or the prerequisite preventing establishment is explicit.
