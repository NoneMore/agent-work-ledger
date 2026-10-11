#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
workflow="$repo_root/integrations/github/workflows/agent-governance.yml"

tmp_root="$(mktemp -d)"
trap 'rm -rf "$tmp_root"' EXIT
validator="$tmp_root/validator.sh"

python3 - "$workflow" > "$validator" <<'PY'
import sys
import yaml

with open(sys.argv[1], encoding="utf-8") as handle:
    workflow = yaml.safe_load(handle)
steps = workflow["jobs"]["validate-resumability"]["steps"]
step = next(step for step in steps if step.get("name") == "Validate PR body")
print("#!/usr/bin/env bash")
print(step["run"])
PY
chmod +x "$validator"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

expect_pass() {
  local name="$1"
  local body="$2"
  local output="$tmp_root/output"
  if ! PR_BODY="$body" "$validator" >"$output" 2>&1; then
    cat "$output" >&2
    fail "$name should pass"
  fi
}

expect_fail() {
  local name="$1"
  local body="$2"
  local expected="$3"
  local output="$tmp_root/output"
  if PR_BODY="$body" "$validator" >"$output" 2>&1; then
    fail "$name should fail"
  fi
  grep -Fq "$expected" "$output" || {
    cat "$output" >&2
    fail "$name did not report expected error: $expected"
  }
}

issue_body='## Tracking
Closes #26

## Current State
Complete.

## Validation
Passed.

## Contract Reconciliation
No durable contract change.'

standalone_body='## Tracking
Standalone maintenance: focused repository cleanup

## Current State
Complete.

## Validation
Passed.

## Contract Reconciliation
No durable contract change.'

commented_pending_body='## Tracking
Standalone maintenance: focused repository cleanup

## Current State
Complete.

## Validation
Passed.

## Contract Reconciliation
No durable contract change.
<!-- OR while unfinished: Pending: <source(s)> -->'

expect_pass 'issue-backed body' "$issue_body"
expect_pass 'standalone body' "$standalone_body"
expect_pass 'commented pending guidance' "$commented_pending_body"

expect_fail 'missing tracking section' 'Closes #26

## Current State
Complete.

## Validation
Passed.

## Contract Reconciliation
No durable contract change.' 'missing required section: ## Tracking'

expect_fail 'mixed tracking modes' '## Tracking
Closes #26
Standalone maintenance: duplicate mode

## Current State
Complete.

## Validation
Passed.

## Contract Reconciliation
No durable contract change.' 'Choose exactly one tracking mode'

expect_fail 'tracking declaration outside section' '## Notes
Closes #26

## Current State
Complete.

## Validation
Passed.

## Contract Reconciliation
No durable contract change.' 'missing required section: ## Tracking'

expect_fail 'missing validation section' '## Tracking
Closes #26

## Current State
Complete.

## Contract Reconciliation
No durable contract change.' 'missing required section: ## Validation'

expect_fail 'missing reconciliation section' '## Tracking
Closes #26

## Current State
Complete.

## Validation
Passed.' 'missing required section: ## Contract Reconciliation'

expect_fail 'pending reconciliation on ready PR' '## Tracking
Standalone maintenance: focused repository cleanup

## Current State
Complete.

## Validation
Passed.

## Contract Reconciliation
Pending: docs/contract.md' 'Pending: is only valid while Draft'

echo 'governance fixtures: ok'
