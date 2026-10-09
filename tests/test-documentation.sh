#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
matches="$(mktemp)"
trap 'rm -f "$matches"' EXIT

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

if grep -R -nF --exclude-dir=.git 'core/AGENTS.md' \
  "$repo_root/README.md" "$repo_root/AGENTS.md" "$repo_root/docs" >"$matches" 2>/dev/null; then
  cat "$matches" >&2
  fail 'documentation still references removed core/AGENTS.md deployment source'
fi

readme_boundary="Agent Work Ledger does not install or modify consumer \`AGENTS.md\` files."
installation_boundary="The installer does not create, overwrite, or merge a target \`AGENTS.md\`."
grep -Fq "$readme_boundary" "$repo_root/README.md" \
  || fail 'README no longer states the consumer AGENTS.md boundary'
grep -Fq "$installation_boundary" "$repo_root/docs/INSTALLATION.md" \
  || fail 'installation docs no longer state the consumer AGENTS.md boundary'

echo 'documentation boundaries: ok'
