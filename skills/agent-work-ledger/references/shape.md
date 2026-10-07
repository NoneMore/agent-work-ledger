# Explore or shape initiative work

Use this path when an Issue owns a durable problem or product lifecycle but the solution, accepted direction, or executable decomposition is not yet stable enough to treat the Issue as a delivery task. The Issue is the canonical shaping surface unless a concrete repository-changing slice gets its own execution surface.

1. Recover the durable problem, current understanding, material evidence, open questions, and any explicitly accepted decisions. Do not infer commitment from how detailed the Issue is.
2. Identify the smallest material uncertainty whose reduction would improve the next decision or decomposition. Gather only evidence needed for that question.
3. Persist conclusions rather than exploratory chain-of-thought: current understanding, useful evidence, remaining open questions, candidate directions, and the next uncertainty-reducing step. Explicitly record when no direction is accepted yet.
4. Treat candidate directions as hypotheses. Do not turn them into implementation requirements until an authorized user or repository decision accepts a direction.
5. When a direction is accepted, record the accepted direction and the material uncertainties that remain. Commitment does not require eliminating every unknown; downstream work may rely on the accepted decision until contradictory evidence explicitly reopens exploration.
6. When delivery can be separated into independently reviewable units, create or identify executable child Issues with their own objective and acceptance criteria. Do not close the parent initiative merely because decomposition is complete when it still owns product/problem acceptance.
7. If exploratory research or design needs repository changes before the parent should close, track that concrete repository-changing slice with an executable Issue/PR surface rather than using a closing link that would falsely imply parent completion.
8. If new evidence invalidates an accepted direction, make that reopening explicit on the canonical initiative surface and reassess affected downstream work rather than silently drifting the contract.

## Done when

The requested shaping increment is complete and the Issue durably captures what is now understood, what is still unknown, which directions are only candidates versus accepted, and the smallest useful next step. An accepted direction or full decomposition is not required unless the user requested that decision.
