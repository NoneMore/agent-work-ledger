#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"$repo_root/tests/test-installer.sh"
"$repo_root/tests/test-governance.sh"
"$repo_root/tests/test-parity.sh"
"$repo_root/tests/test-documentation.sh"
"$repo_root/tests/static-validation.sh"

echo 'release checks: ok'
