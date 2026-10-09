#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
installer="$repo_root/install/install.sh"

tmp_root="$(mktemp -d)"
trap 'rm -rf "$tmp_root"' EXIT

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

assert_file() {
  [[ -f "$1" ]] || fail "expected file: $1"
}

assert_no_file() {
  [[ ! -e "$1" ]] || fail "unexpected path: $1"
}

assert_same() {
  cmp -s "$1" "$2" || fail "files differ: $1 $2"
}

run_profile() {
  local profile="$1"
  local target="$tmp_root/$profile"
  mkdir -p "$target"
  printf '%s\n' '# repository-local instructions' > "$target/AGENTS.md"
  cp "$target/AGENTS.md" "$target/AGENTS.before"

  "$installer" --profile "$profile" --target "$target" >/dev/null

  assert_file "$target/.agents/skills/agent-work-ledger/SKILL.md"
  assert_same "$target/AGENTS.before" "$target/AGENTS.md"

  if [[ "$profile" == "github" ]]; then
    local path
    for path in \
      ISSUE_TEMPLATE/agent-task.yml \
      ISSUE_TEMPLATE/initiative.yml \
      pull_request_template.md \
      workflows/agent-governance.yml \
      rulesets/main.json; do
      assert_file "$target/.github/$path"
      assert_same "$repo_root/integrations/github/$path" "$target/.github/$path"
    done
  else
    assert_no_file "$target/.github"
  fi
}

run_profile core
run_profile skill-only
run_profile github

legacy_target="$tmp_root/legacy"
mkdir -p "$legacy_target"
cat > "$legacy_target/AGENTS.md" <<'LEGACY'
# Agent Working Protocol
GitHub is the durable system of record for agent work.
Keep this custom line.
LEGACY
cp "$legacy_target/AGENTS.md" "$legacy_target/AGENTS.before"
legacy_stderr="$tmp_root/legacy.stderr"
"$installer" --profile core --target "$legacy_target" >/dev/null 2>"$legacy_stderr"
assert_same "$legacy_target/AGENTS.before" "$legacy_target/AGENTS.md"
grep -Fq 'Warning: detected legacy Agent Work Ledger policy' "$legacy_stderr" \
  || fail "legacy policy warning was not emitted"

mock_bin="$tmp_root/mock-bin"
mkdir -p "$mock_bin"
cat > "$mock_bin/gh" <<'MOCK'
#!/usr/bin/env bash
set -euo pipefail

{
  printf 'gh'
  printf ' %q' "$@"
  printf '\n'
} >> "${GH_LOG:?}"

case "${1:-}" in
  auth)
    [[ "${2:-}" == "status" ]] || exit 2
    ;;
  repo)
    [[ "${2:-}" == "view" ]] || exit 2
    printf '%s\n' "${GH_REPO:-acme/demo}"
    ;;
  api)
    if [[ "$*" == *'rulesets?includes_parents=false'* ]]; then
      printf '%s\n' "${GH_RULESET_ID:-}"
    fi
    ;;
  *)
    exit 2
    ;;
esac
MOCK
chmod +x "$mock_bin/gh"

create_target="$tmp_root/ruleset-create"
mkdir -p "$create_target"
create_log="$tmp_root/create.log"
GH_LOG="$create_log" GH_REPO='acme/inferred' GH_RULESET_ID='' PATH="$mock_bin:$PATH" \
  "$installer" --profile github --target "$create_target" --apply-ruleset >/dev/null

grep -Fq 'gh repo view --json nameWithOwner --jq .nameWithOwner' "$create_log" \
  || fail "ruleset application did not infer repository"
grep -Fq 'repos/acme/inferred/rulesets\?includes_parents=false' "$create_log" \
  || fail "ruleset lookup did not exclude parent rulesets"
grep -Fq -- '--method POST repos/acme/inferred/rulesets' "$create_log" \
  || fail "ruleset create path was not used"

update_target="$tmp_root/ruleset-update"
mkdir -p "$update_target"
update_log="$tmp_root/update.log"
GH_LOG="$update_log" GH_RULESET_ID='77' PATH="$mock_bin:$PATH" \
  "$installer" --profile github --target "$update_target" --apply-ruleset --repo acme/explicit >/dev/null

if grep -Fq 'gh repo view' "$update_log"; then
  fail "explicit repository unexpectedly triggered repository inference"
fi
grep -Fq 'repos/acme/explicit/rulesets\?includes_parents=false' "$update_log" \
  || fail "ruleset update lookup did not exclude parent rulesets"
grep -Fq -- '--method PUT repos/acme/explicit/rulesets/77' "$update_log" \
  || fail "ruleset update path was not used"

echo 'installer fixtures: ok'
