#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: install/install.sh [--profile core|github|skill-only] [--target PATH]

Profiles:
  core        Install AGENTS.md and the Agent Skill.
  github      Install core plus GitHub Issue/PR/governance/ruleset files.
  skill-only  Install only the Agent Skill.

The installer never overwrites an existing target AGENTS.md. Merge the policy
manually when the target repository already has workspace instructions.
EOF
}

profile="core"
target="."

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

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="$(mkdir -p "$target" && cd "$target" && pwd)"

install_skill() {
  mkdir -p "$target/.agents/skills"
  rm -rf "$target/.agents/skills/agent-work-ledger"
  cp -R "$repo_root/skills/agent-work-ledger" "$target/.agents/skills/agent-work-ledger"
}

install_agents() {
  if [[ -e "$target/AGENTS.md" ]]; then
    echo "Refusing to overwrite existing $target/AGENTS.md." >&2
    echo "Merge $repo_root/AGENTS.md into the target repository manually." >&2
    exit 3
  fi
  cp "$repo_root/AGENTS.md" "$target/AGENTS.md"
}

install_github() {
  mkdir -p \
    "$target/.github/ISSUE_TEMPLATE" \
    "$target/.github/workflows" \
    "$target/.github/rulesets"
  cp "$repo_root/.github/ISSUE_TEMPLATE/agent-task.yml" "$target/.github/ISSUE_TEMPLATE/agent-task.yml"
  cp "$repo_root/.github/pull_request_template.md" "$target/.github/pull_request_template.md"
  cp "$repo_root/.github/workflows/agent-governance.yml" "$target/.github/workflows/agent-governance.yml"
  cp "$repo_root/.github/rulesets/main.json" "$target/.github/rulesets/main.json"
}

install_skill

case "$profile" in
  skill-only)
    ;;
  core)
    install_agents
    ;;
  github)
    install_agents
    install_github
    ;;
esac

echo "Installed Agent Work Ledger profile '$profile' into $target"
