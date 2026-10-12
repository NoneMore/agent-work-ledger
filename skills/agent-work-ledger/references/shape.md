# Coordinate initiative shaping

Use for initiative-level shaping or acceptance work that is not itself a concrete executable delivery slice, including unstable direction/decomposition, recording authorized decisions, and evaluating parent-level acceptance after child delivery.

The Initiative Issue is the canonical shaping surface when one exists. If durable tracking is explicitly requested or required by repository policy and no canonical Initiative Issue exists yet, create or adopt one when authorized; do not invent an executable Objective/Acceptance Criteria contract merely to establish tracking.

The ledger owns the shaping lifecycle and durable shaping state. It may determine what kind of substantive outcome is needed next, but it does not independently produce product/design direction, specification, decomposition, investigation conclusions, or acceptance judgments that require domain expertise or decision authority.

## Recover

Read only enough durable state to establish:

- the problem/current understanding,
- material evidence and open questions,
- candidate directions and any explicitly accepted decisions,
- known executable child work plus remaining parent-level acceptance when decomposition has begun,
- decision or authority constraints relevant to the requested shaping work,
- the next recorded shaping action and whether it still follows from current state.

Do not infer commitment from detail, completeness, or the presence of a next step.

## Coordinate

Determine the smallest missing shaping outcome that would materially advance the initiative. Examples include additional investigation, a design decision, a specification, executable decomposition, or parent-level acceptance evaluation.

Route that outcome to the appropriate substantive executor, capability, or authorized decision-maker. Provide the current durable problem state, relevant evidence, constraints, and accepted decisions as input. Do not silently choose the substantive answer through ledger policy.

## Leave durable

Update the Initiative Issue only with material resulting state needed for safe resumption, such as:

- changed understanding or useful evidence returned by substantive work,
- remaining material questions,
- candidate versus accepted direction, including when no direction is accepted yet,
- material changes to executable decomposition and parent-level acceptance that still remains,
- the next useful uncertainty-reducing, decision, decomposition, or acceptance step.

Persist conclusions and decisions, not exploratory chain-of-thought.

## Boundaries

- Candidate directions remain hypotheses until an authorized decision explicitly accepts one; changing or reopening an accepted direction requires the authority needed to change that decision.
- The ledger may record or coordinate candidate generation/comparison, but substantive design judgment belongs to the relevant executor or decision-maker.
- Independently executable delivery should move into child Issues/PRs without prematurely closing a parent initiative that still owns product/problem acceptance.
- Deciding truthful decomposition boundaries belongs to the relevant decomposition capability; the ledger records the resulting child relationships, dependencies, and remaining parent-level acceptance without mirroring child open/closed state.
- Repository-changing research or design that does not complete the parent should use a concrete executable Issue/PR surface rather than a false closing link to the parent.
- If contradictory evidence invalidates an accepted direction, record the evidence and any known child work that may need follow-up. Reopen or replace the accepted direction only with the required decision authority; otherwise leave reconsideration as the exact next action, and do not continue downstream reliance when doing so would be unsafe.
- Parent-level acceptance may be tracked by the ledger, but any substantive product/technical judgment required to determine acceptance must come from the appropriate evaluator or authorized decision-maker.
- When the GitHub integration provides an Exploratory Initiative Issue Form, prefer it for new initiatives; the form is intake scaffolding, not a semantic readiness test or required heading schema.

## Done when

The requested initiative-level increment has been coordinated, the canonical Initiative Issue when used captures the resulting durable understanding/decision/decomposition/acceptance state, and the next shaping obligation is explicit. An accepted direction or full decomposition is not required unless the user requested that outcome; finalizing transitions such as closing the Initiative still require the applicable authority.