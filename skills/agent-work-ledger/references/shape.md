# Explore or shape initiative work

Use when a durable problem or product lifecycle needs shaping but its accepted direction or executable decomposition is not yet stable enough to treat the initiative as a delivery task. If the work needs an independent lifecycle and no canonical Initiative Issue exists yet, create or adopt one when authorized before shaping; do not invent an executable Objective/Acceptance Criteria contract merely to establish tracking. The Issue is the canonical shaping surface unless a concrete repository-changing slice gets its own execution surface.

## Recover

Read only enough durable state to establish:

- the problem/current understanding,
- material evidence and open questions,
- candidate directions and any explicitly accepted decisions,
- executable child or affected downstream work plus remaining parent-level acceptance when decomposition has begun,
- decision or authority constraints relevant to the requested shaping work.

For a new initiative with no existing Issue, use current user intent and the smallest relevant evidence to establish the canonical Initiative Issue before continuing. Do not infer commitment from detail, completeness, or the presence of a next step.

## Leave durable

Update the Initiative Issue only with material resulting state needed for safe resumption, such as:

- changed understanding or useful evidence,
- remaining material questions,
- candidate versus accepted direction, including when no direction is accepted yet,
- material changes to executable decomposition, affected child work, and parent-level acceptance that still remains,
- the next useful uncertainty-reducing step.

Persist conclusions and decisions, not exploratory chain-of-thought.

## Boundaries

- Candidate directions remain hypotheses until an authorized decision explicitly accepts one; commitment may leave implementation-local unknowns unresolved.
- Independently executable delivery should move into child Issues/PRs without prematurely closing a parent initiative that still owns product/problem acceptance.
- Repository-changing research or design that does not complete the parent should use a concrete executable Issue/PR surface rather than a false closing link to the parent.
- Contradictory evidence that invalidates an accepted direction must explicitly reopen that decision and trigger reassessment of affected downstream work.
- When the GitHub integration provides an Exploratory Initiative Issue Form, prefer it for new initiatives; the form is intake scaffolding, not a semantic readiness test or required heading schema.

## Done when

The requested shaping increment is complete and the canonical Initiative Issue durably captures the resulting understanding, decision state, material unknowns, affected decomposition when relevant, and next useful step. An accepted direction or full decomposition is not required unless the user requested that outcome.
