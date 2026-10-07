# Explore or shape initiative work

Use when an Issue owns a durable problem or product lifecycle but its accepted direction or executable decomposition is not yet stable enough to treat the initiative as a delivery task. The Issue is the canonical shaping surface unless a concrete repository-changing slice gets its own execution surface.

## Recover

Read only enough durable state to establish:

- the problem/current understanding,
- material evidence and open questions,
- candidate directions and any explicitly accepted decisions,
- decision or authority constraints relevant to the requested shaping work.

Do not infer commitment from detail, completeness, or the presence of a next step.

## Leave durable

Update the Issue only with material resulting state needed for safe resumption, such as:

- changed understanding or useful evidence,
- remaining material questions,
- candidate versus accepted direction, including when no direction is accepted yet,
- the next useful uncertainty-reducing step.

Persist conclusions and decisions, not exploratory chain-of-thought.

## Boundaries

- Candidate directions remain hypotheses until an authorized decision explicitly accepts one; commitment may leave implementation-local unknowns unresolved.
- Independently executable delivery should move into child Issues/PRs without prematurely closing a parent initiative that still owns product/problem acceptance.
- Repository-changing research or design that does not complete the parent should use a concrete executable Issue/PR surface rather than a false closing link to the parent.
- Contradictory evidence that invalidates an accepted direction must explicitly reopen that decision and trigger reassessment of affected downstream work.

## Done when

The requested shaping increment is complete and the Issue durably captures the resulting understanding, decision state, material unknowns, and next useful step. An accepted direction or full decomposition is not required unless the user requested that outcome.
