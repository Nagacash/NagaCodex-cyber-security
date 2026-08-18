---
name: secrets-scan
description: >
  Detect hardcoded secrets, API keys, tokens, and credentials in source,
  config, CI, and history. Use before commits, releases, or client handoff.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: appsec
  frameworks: "CWE, OWASP-Top-10, NIST-SP-800-57"
---

# Secrets Scan

## When to use
- "scan for secrets", "API keys in repo"
- Pre-release / pre-open-source
- Incident suspicion of leaked credentials

## Workflow

### 1. High-signal patterns
Search for (non-exhaustive):
- `AKIA[0-9A-Z]{16}` (AWS)
- `-----BEGIN (RSA|OPENSSH|EC) PRIVATE KEY-----`
- `ghp_`, `github_pat_`, `xox[baprs]-` (Slack)
- `sk-[a-zA-Z0-9]{20,}`, `sk-proj-`
- `AIza`, `ya29.`
- `password\s*=\s*['\"][^'\"]+`
- Connection strings with credentials
- `.env` committed; `credentials.json`; kubeconfigs

### 2. Locations
- Working tree + common config paths
- CI workflows (`.github/workflows`)
- Docker/compose files
- Mobile configs, IaC
- If authorized and needed: git history (`git log -p` / specialized tools)

### 3. Triage
| Class | Action |
|-------|--------|
| Live production secret | **Critical** — rotate immediately |
| Test/dummy clearly fake | Info or false_positive |
| Example in docs with obvious placeholder | Info |
| Private key material | Critical/High |

### 4. Never
- Print full secrets in reports — fully redact (`[REDACTED]`); never partial masks that leave password characters (and watch for `@` inside passwords breaking `user:secret@host` parsing)
- Commit findings that re-expose the secret

## Remediation standard
1. Rotate/revoke
2. Remove from history if leaked publicly
3. Move to secret manager / OIDC
4. Add pre-commit + CI secret scanning

## Framework map
- CWE-798, CWE-321
- OWASP A07 / A02
- NIST SP 800-57 (key management concepts)

