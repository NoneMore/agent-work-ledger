# Maintain initiative shaping state

Use for initiative-level state that is not itself a concrete executable delivery slice, including current understanding, accepted decisions, decomposition already established elsewhere, and parent-level acceptance state.

The Initiative Issue is the canonical shaping surface when one exists. If durable tracking is explicitly requested or required by repository policy and no canonical Initiative Issue exists yet, create or adopt one when authorized; do not invent an executable Objective/Acceptance Criteria contract merely to establish tracking.

The ledger owns durable shaping state, not shaping work.

## Recover

Read only enough authoritative state to establish:

- the problem/current understanding;
- material evidence already recorded;
- open questions or uncertainties;
- candidate directions and explicitly accepted decisions;
- known executable child relationships plus remaining parent-level acceptance when already established;
- authority constraints;
- the recorded next shaping action and whether current authoritative evidence still supports it.

Do not infer commitment from detail, completeness, or the presence of a next step.

## Reconcile

Update the Initiative Issue only from authoritative evidence or explicit authorized input. The ledger may record:

- changed understanding or evidence already established elsewhere;
- questions that remain open;
- candidate versus accepted direction;
- established child relationships/dependencies and remaining parent-level acceptance;
- an exact next action already established by the user or authoritative project state.

Do not investigate, generate or compare design directions, specify requirements, decide decomposition, evaluate substantive parent acceptance, select an owner, or invoke another capability. If the next shaping action or decision cannot be established without such judgment, leave the uncertainty explicit and ask the user.

## Boundaries

- Candidate directions remain hypotheses until an authorized decision explicitly accepts one; changing or reopening an accepted direction requires the authority needed to change that decision.
- Independently executable delivery should move into child Issues/PRs without prematurely closing a parent initiative that still owns product/problem acceptance.
- Parent initiatives may record child relationships, dependencies, accepted direction, and remaining parent-level acceptance, but should not mirror child open/closed state.
- Repository-changing research or design that does not complete the parent should use a concrete executable Issue/PR surface rather than a false closing link to the parent.
- If contradictory evidence affects an accepted direction, record the evidence and known state consequences. Do not decide whether to reopen/replace the direction without the required authority; leave reconsideration as the next action when unresolved.
- When the GitHub integration provides an Exploratory Initiative Issue Form, prefer it for new initiatives; the form is intake scaffolding, not a semantic readiness test or required heading schema.

## Done when

The canonical Initiative Issue, when used, accurately reflects authoritative understanding, decision/decomposition/acceptance state, material unknowns, and the established next action; any judgment still required is explicit rather than performed by the ledger.
