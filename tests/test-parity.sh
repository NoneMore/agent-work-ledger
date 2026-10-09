#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

for path in \
  ISSUE_TEMPLATE/agent-task.yml \
  ISSUE_TEMPLATE/initiative.yml \
  pull_request_template.md \
  workflows/agent-governance.yml \
  rulesets/main.json; do
  source_file="$repo_root/integrations/github/$path"
  dogfood_file="$repo_root/.github/$path"
  [[ -f "$source_file" ]] || fail "missing deployable source: $source_file"
  [[ -f "$dogfood_file" ]] || fail "missing dogfood copy: $dogfood_file"
  cmp -s "$source_file" "$dogfood_file" || fail "dogfood drift: $path"
done

echo 'deployable/dogfood parity: ok'
