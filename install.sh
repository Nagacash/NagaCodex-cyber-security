#!/usr/bin/env bash
# Install Naga Codex Cyber Security skills into common agent skill paths.
# Defensive consulting pack — authorized audits only.
# Compatible with bash without /dev/fd process substitution.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
MODE="${1:-claude}"
DEST_OVERRIDE="${2:-}"
TMP_LIST="$(mktemp)"
trap 'rm -f "$TMP_LIST"' EXIT

red()  { printf '%s\n' "ERROR: $*" >&2; }
grn()  { printf '%s\n' "OK: $*"; }
ylw()  { printf '%s\n' "NOTE: $*"; }

build_list() {
  find "$ROOT/skills" -mindepth 2 -maxdepth 2 -type d | sort > "$TMP_LIST"
}

skill_count() {
  build_list
  wc -l < "$TMP_LIST" | tr -d ' '
}

install_flat() {
  local dest="$1"
  mkdir -p "$dest"
  build_list
  local n=0 collisions=0 skilldir name
  while IFS= read -r skilldir; do
    [ -z "$skilldir" ] && continue
    name="$(basename "$skilldir")"
    if [ -e "$dest/$name" ]; then
      if [ -f "$dest/$name/SKILL.md" ] && grep -q 'author: naga-codex' "$dest/$name/SKILL.md" 2>/dev/null; then
        rm -rf "$dest/$name"
      else
        ylw "skip collision (exists, not Naga): $dest/$name"
        collisions=$((collisions+1))
        continue
      fi
    fi
    cp -R "$skilldir" "$dest/$name"
    echo "  + $name -> $dest/$name"
    n=$((n+1))
  done < "$TMP_LIST"
  grn "Installed $n skills (flat) -> $dest"
  if [ "$collisions" -gt 0 ]; then
    ylw "$collisions basename collision(s). Prefer: ./install.sh hermes"
    return 1
  fi
  return 0
}

install_namespaced() {
  local skills_root="$1"
  local ns="${2:-naga-codex}"

  if [ -z "$skills_root" ] || [ "$skills_root" = "/" ]; then
    red "Refusing empty or root skills_root"
    exit 2
  fi

  # skills_root must be the multi-pack root (e.g. /opt/data/skills), NOT a foreign pack.
  local base
  base="$(basename "$skills_root")"
  case "$base" in
    cybersecurity|omh|security)
      ylw "Refusing foreign pack dir as root: $skills_root"
      skills_root="$(dirname "$skills_root")"
      ylw "Using parent: $skills_root"
      ;;
  esac

  local dest="$skills_root/$ns"
  mkdir -p "$dest"

  # Remove previous Naga namespace contents only
  if [ -d "$dest" ]; then
    find "$dest" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
  fi

  build_list
  local n=0 skilldir name domain
  while IFS= read -r skilldir; do
    [ -z "$skilldir" ] && continue
    name="$(basename "$skilldir")"
    domain="$(basename "$(dirname "$skilldir")")"
    mkdir -p "$dest/$domain"
    cp -R "$skilldir" "$dest/$domain/$name"
    echo "  + $domain/$name"
    n=$((n+1))
  done < "$TMP_LIST"

  # Informational: basenames also living outside our namespace
  local amb=0
  while IFS= read -r skilldir; do
    [ -z "$skilldir" ] && continue
    name="$(basename "$skilldir")"
    extra="$(find "$skills_root" -mindepth 2 -maxdepth 5 -type d -name "$name" 2>/dev/null \
      | grep -v "^${dest}/" || true)"
    extra="$(printf '%s\n' "$extra" | sed '/^$/d' | wc -l | tr -d ' ')"
    if [ "${extra:-0}" -gt 0 ]; then
      if [ "$amb" -eq 0 ]; then
        ylw "Basename also exists outside $ns (flat loaders may be ambiguous):"
      fi
      echo "  ! $name (extra dirs: $extra)"
      amb=$((amb+1))
    fi
  done < "$TMP_LIST"

  cat > "$dest/INSTALL_MANIFEST.txt" <<EOF
naga-codex-cyber-security
namespace=$ns
skills=$n
installed_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
layout=domain/skill
posture=defensive-consulting
source=https://github.com/Nagacash/NagaCodex-cyber-security
EOF

  if [ "$n" -ne 25 ]; then
    red "Expected 25 skills, installed $n"
    exit 1
  fi
  grn "Installed $n skills (namespaced) -> $dest"
  echo "Verify: ./scripts/verify-install.sh \"$dest\""
}

install_cursor_rule() {
  mkdir -p .cursor/rules
  cat > .cursor/rules/naga-codex-cyber.mdc << 'EOF'
---
description: Naga Codex Cyber Security — defensive consulting skills (AppSec, AI/MCP, GDPR/NIS2, IR)
globs:
alwaysApply: false
---
When the user asks for security audits, authorized assessments, OWASP/LLM/agent reviews, secrets scanning,
cloud hardening, incident triage, or EU compliance (GDPR, NIS2, ISO 27001, BSI), follow the
Naga Codex Cyber Security skills. Always run authorization-gate before active testing.
Posture: defensive consulting only — not an offensive toolkit. Emit findings using the Naga Codex schema.
Prefer bilingual EN/DE client reports for DACH engagements.
EOF
  echo "  + .cursor/rules/naga-codex-cyber.mdc"
}

echo "Naga Codex Cyber Security installer"
echo "Skills in pack: $(skill_count)"
echo "Mode: $MODE"

case "$MODE" in
  claude)
    install_flat "${DEST_OVERRIDE:-$HOME/.claude/skills}" || true
    ;;
  project-claude)
    install_flat "${DEST_OVERRIDE:-.claude/skills}" || true
    ;;
  agents)
    install_flat "${DEST_OVERRIDE:-.agents/skills}" || true
    ;;
  cursor)
    install_flat "${DEST_OVERRIDE:-.cursor/skills}" || true
    install_cursor_rule
    ;;
  hermes)
    SKILLS_ROOT="${DEST_OVERRIDE:-${SKILLS_DIR:-/opt/data/skills}}"
    echo "Hermes skills root: $SKILLS_ROOT"
    echo "Namespace: naga-codex/  (never writes into foreign packs)"
    install_namespaced "$SKILLS_ROOT" "naga-codex"
    ;;
  namespaced)
    SKILLS_ROOT="${DEST_OVERRIDE:-.}"
    NS="${3:-naga-codex}"
    install_namespaced "$SKILLS_ROOT" "$NS"
    ;;
  *)
    cat <<'USAGE'
Usage: ./install.sh <mode> [dest]

  claude | project-claude | agents | cursor   Flat install by skill basename
  hermes [SKILLS_DIR]                         -> SKILLS_DIR/naga-codex/<domain>/<skill>
  namespaced <root> [ns]                      Custom namespaced install

Hermes (correct):
  export SKILLS_DIR=/opt/data/skills
  ./install.sh hermes
  ./scripts/verify-install.sh "$SKILLS_DIR/naga-codex"

Never: cp -r skills/* /opt/data/skills/cybersecurity/
Always: ./install.sh hermes
USAGE
    exit 1
    ;;
esac

echo "Done. docs/hermes-install.md · examples/README.md"
