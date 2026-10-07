# Explore or shape initiative work

Use when a durable problem or product lifecycle needs shaping but its accepted direction or executable decomposition is not yet stable enough to treat the initiative as a delivery task. The Initiative Issue is the canonical shaping surface when one exists. If durable tracking is explicitly requested or required by repository policy and no canonical Initiative Issue exists yet, create or adopt one when authorized; do not invent an executable Objective/Acceptance Criteria contract merely to establish tracking.

## Recover

Read only enough durable state to establish:

- the problem/current understanding,
- material evidence and open questions,
- candidate directions and any explicitly accepted decisions,
- known executable child work plus remaining parent-level acceptance when decomposition has begun,
- decision or authority constraints relevant to the requested shaping work.

Do not infer commitment from detail, completeness, or the presence of a next step.

## Leave durable

Update the Initiative Issue only with material resulting state needed for safe resumption, such as:

- changed understanding or useful evidence,
- remaining material questions,
- candidate versus accepted direction, including when no direction is accepted yet,
- material changes to executable decomposition and parent-level acceptance that still remains,
- the next useful uncertainty-reducing step.

Persist conclusions and decisions, not exploratory chain-of-thought.

## Boundaries

- Candidate directions remain hypotheses until an authorized decision explicitly accepts one; commitment may leave implementation-local unknowns unresolved.
- Independently executable delivery should move into child Issues/PRs without prematurely closing a parent initiative that still owns product/problem acceptance.
- Repository-changing research or design that does not complete the parent should use a concrete executable Issue/PR surface rather than a false closing link to the parent.
- If contradictory evidence invalidates an accepted direction, explicitly reopen that decision and record any known child work that may need follow-up; broad downstream reassessment is not required as part of shaping.
- When the GitHub integration provides an Exploratory Initiative Issue Form, prefer it for new initiatives; the form is intake scaffolding, not a semantic readiness test or required heading schema.

## Done when

The requested shaping increment is complete and the canonical Initiative Issue, when used, durably captures the resulting understanding, decision state, material unknowns, decomposition when relevant, and next useful step. An accepted direction or full decomposition is not required unless the user requested that outcome.
