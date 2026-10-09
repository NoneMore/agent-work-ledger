#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: install/install.sh [--profile core|github|skill-only] [--target PATH]
                          [--apply-ruleset] [--repo OWNER/REPO]

Profiles:
  core        Install the Agent Skill.
  github      Install the Agent Skill plus GitHub Issue/PR/governance/ruleset files.
  skill-only  Install only the Agent Skill (compatibility alias for core).

Options:
  --apply-ruleset  With the github profile, create or update the repository
                   ruleset through `gh api` after installing the files.
  --repo OWNER/REPO
                   Repository to configure when applying the ruleset. When
                   omitted, infer it from the target repository checkout.
EOF
}

profile="core"
target="."
apply_ruleset=false
github_repo=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile)
      profile="${2:-}"
      shift 2
      ;;
    --target)
      target="${2:-}"
      shift 2
      ;;
    --apply-ruleset)
      apply_ruleset=true
      shift
      ;;
    --repo)
      github_repo="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

case "$profile" in
  core|github|skill-only) ;;
  *)
    echo "Unknown profile: $profile" >&2
    usage >&2
    exit 2
    ;;
esac

if [[ "$apply_ruleset" == true && "$profile" != "github" ]]; then
  echo "--apply-ruleset requires --profile github." >&2
  exit 2
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="$(mkdir -p "$target" && cd "$target" && pwd)"

if [[ "$apply_ruleset" == true ]]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "--apply-ruleset requires GitHub CLI (gh)." >&2
    exit 4
  fi

  if ! gh auth status >/dev/null 2>&1; then
    echo "GitHub CLI is not authenticated. Run 'gh auth login' first." >&2
    exit 4
  fi

  if [[ -z "$github_repo" ]]; then
    if ! github_repo="$(cd "$target" && gh repo view --json nameWithOwner --jq '.nameWithOwner' 2>/dev/null)" || [[ -z "$github_repo" ]]; then
      echo "Could not infer a GitHub repository from $target; pass --repo OWNER/REPO." >&2
      exit 4
    fi
  fi
fi

install_skill() {
  mkdir -p "$target/.agents/skills"
  rm -rf "$target/.agents/skills/agent-work-ledger"
  cp -R "$repo_root/skills/agent-work-ledger" "$target/.agents/skills/agent-work-ledger"
}

install_github() {
  mkdir -p \
    "$target/.github/ISSUE_TEMPLATE" \
    "$target/.github/workflows" \
    "$target/.github/rulesets"
  cp "$repo_root/integrations/github/ISSUE_TEMPLATE/agent-task.yml" "$target/.github/ISSUE_TEMPLATE/agent-task.yml"
  cp "$repo_root/integrations/github/ISSUE_TEMPLATE/initiative.yml" "$target/.github/ISSUE_TEMPLATE/initiative.yml"
  cp "$repo_root/integrations/github/pull_request_template.md" "$target/.github/pull_request_template.md"
  cp "$repo_root/integrations/github/workflows/agent-governance.yml" "$target/.github/workflows/agent-governance.yml"
  cp "$repo_root/integrations/github/rulesets/main.json" "$target/.github/rulesets/main.json"
}

apply_github_ruleset() {
  local ruleset_file="$repo_root/integrations/github/rulesets/main.json"
  local ruleset_name="Main branch"
  local ruleset_id

  ruleset_id="$(
    gh api "repos/$github_repo/rulesets?includes_parents=false" --paginate \
      --jq ".[] | select(.name == \"$ruleset_name\") | .id" \
      | sed -n '1p'
  )"

  if [[ -n "$ruleset_id" ]]; then
    gh api --method PUT "repos/$github_repo/rulesets/$ruleset_id" \
      --input "$ruleset_file" >/dev/null
    echo "Updated ruleset '$ruleset_name' on $github_repo"
  else
    gh api --method POST "repos/$github_repo/rulesets" \
      --input "$ruleset_file" >/dev/null
    echo "Created ruleset '$ruleset_name' on $github_repo"
  fi
}

install_skill

if [[ "$profile" == "github" ]]; then
  install_github
fi

echo "Installed Agent Work Ledger profile '$profile' into $target"

if [[ "$apply_ruleset" == true ]]; then
  apply_github_ruleset
fi
