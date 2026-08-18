#!/usr/bin/env bash
# Install Naga Codex Cyber Security skills into common agent skill paths.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
MODE="${1:-claude}"

install_tree() {
  local dest="$1"
  mkdir -p "$dest"
  # Flat install: each skill directory copied by name for agent discovery
  while IFS= read -r -d '' skilldir; do
    name="$(basename "$skilldir")"
    rm -rf "$dest/$name"
    cp -R "$skilldir" "$dest/$name"
    echo "  + $name -> $dest/$name"
  done < <(find "$ROOT/skills" -mindepth 2 -maxdepth 2 -type d -print0)
}

case "$MODE" in
  claude)
    DEST="${2:-$HOME/.claude/skills}"
    echo "Installing to Claude Code skills: $DEST"
    install_tree "$DEST"
    ;;
  project-claude)
    DEST="${2:-.claude/skills}"
    echo "Installing to project Claude skills: $DEST"
    install_tree "$DEST"
    ;;
  agents)
    DEST="${2:-.agents/skills}"
    echo "Installing to .agents/skills: $DEST"
    install_tree "$DEST"
    ;;
  cursor)
    DEST="${2:-.cursor/skills}"
    echo "Installing to Cursor skills: $DEST"
    install_tree "$DEST"
    # Also emit lightweight rules pointers
    mkdir -p .cursor/rules
    cat > .cursor/rules/naga-codex-cyber.mdc << 'EOF'
---
description: Naga Codex Cyber Security — load security skills for audits, AppSec, AI/MCP, GDPR/NIS2
globs:
alwaysApply: false
---
When the user asks for security audits, pentests, OWASP/LLM/agent reviews, secrets scanning,
cloud hardening, incident triage, or EU compliance (GDPR, NIS2, ISO 27001, BSI), follow the
Naga Codex Cyber Security skills installed under the skills path. Always run authorization-gate
before active testing. Emit findings using the Naga Codex finding schema. Prefer bilingual
EN/DE client reports for DACH engagements.
EOF
    echo "  + .cursor/rules/naga-codex-cyber.mdc"
    ;;
  *)
    echo "Usage: ./install.sh [claude|project-claude|agents|cursor] [dest]"
    exit 1
    ;;
esac

echo "Done. See docs/catalog.md for skill list."
