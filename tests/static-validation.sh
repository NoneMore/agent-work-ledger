#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

command -v shellcheck >/dev/null 2>&1 || {
  echo 'shellcheck is required' >&2
  exit 1
}
python3 -c 'import yaml' >/dev/null 2>&1 || {
  echo 'PyYAML is required' >&2
  exit 1
}

mapfile -d '' shell_files < <(find "$repo_root/install" "$repo_root/tests" -type f -name '*.sh' -print0 | sort -z)
for path in "${shell_files[@]}"; do
  bash -n "$path"
done
shellcheck -x "${shell_files[@]}"

python3 - "$repo_root" <<'PY'
import json
import pathlib
import sys
import yaml

root = pathlib.Path(sys.argv[1])
for path in sorted(root.rglob("*.json")):
    with path.open(encoding="utf-8") as handle:
        json.load(handle)
for pattern in ("*.yml", "*.yaml"):
    for path in sorted(root.rglob(pattern)):
        with path.open(encoding="utf-8") as handle:
            yaml.compose(handle)
PY

tmp_root="$(mktemp -d)"
trap 'rm -rf "$tmp_root"' EXIT
validator="$tmp_root/governance-validator.sh"
python3 - "$repo_root/integrations/github/workflows/agent-governance.yml" > "$validator" <<'PY'
import sys
import yaml

with open(sys.argv[1], encoding="utf-8") as handle:
    workflow = yaml.safe_load(handle)
steps = workflow["jobs"]["validate-resumability"]["steps"]
step = next(step for step in steps if step.get("name") == "Validate PR body")
print("#!/usr/bin/env bash")
print(step["run"])
PY
shellcheck -s bash "$validator"

echo 'static validation: ok'
