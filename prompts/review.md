# Review a Pull Request

Use this for a human- or agent-assisted review of an implementation PR.

```text
Review PR #[PR] against its linked Issue.

Follow AGENTS.md. Review from durable evidence rather than trusting the PR summary alone.

Use this evidence order:
1. linked Issue objective and acceptance criteria,
2. repository diff and relevant surrounding code,
3. tests, CI, and other validation evidence,
4. PR `Current State`, `Validation`, and useful notes,
5. historical comments only when needed for decision context.

Check for:
- unmet acceptance criteria,
- correctness or regression risks,
- missing validation,
- behavior that violates explicit constraints,
- unintended scope or unrelated changes,
- stale or misleading execution-state prose.

For each requested change, identify the concrete code location or artifact, explain the observable concern, and state the minimum correction needed. Do not request speculative refactors unrelated to the Issue.

If the implementation is acceptable, say so based on the evidence reviewed and call out any validation limitations that remain.

Do not expose or request private chain-of-thought. Record concise findings, evidence, and required actions.
```
