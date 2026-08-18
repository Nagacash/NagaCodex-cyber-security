#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-}"
if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
  echo "Usage: $0 <install-root>"
  echo "  e.g. $0 /opt/data/skills/naga-codex"
  exit 2
fi

count="$(find "$TARGET" -type f -name SKILL.md | wc -l | tr -d ' ')"
echo "SKILL.md files: $count"
if [ "$count" -ne 25 ]; then
  echo "FAIL: expected 25 skills, found $count"
  find "$TARGET" -type f -name SKILL.md | head
  exit 1
fi

dups="$(find "$TARGET" -type f -name SKILL.md -exec dirname {} \; \
  | xargs -I{} basename {} | sort | uniq -d || true)"
if [ -n "$dups" ]; then
  echo "FAIL: duplicate basenames:"
  echo "$dups"
  exit 1
fi

missing=0
find "$TARGET" -type f -name SKILL.md | while read -r f; do
  if ! grep -q 'author: naga-codex' "$f"; then
    echo "WARN: missing naga-codex author: $f"
  fi
done

echo "OK: 25 unique Naga skills under $TARGET"
exit 0
