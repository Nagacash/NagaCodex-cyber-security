---
name: secure-code-review
description: >
  Structured security code review against OWASP ASVS and CWE Top 25. Use for
  PR review, module audits, pre-merge gates, or full application source review.
  Covers injection, authn/authz, crypto, data exposure, and deserialization.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: appsec
  frameworks: "OWASP-ASVS-4.0.3, OWASP-Top-10, CWE"
---

# Secure Code Review

## When to use
- "review this code for security"
- PR / diff security gate
- Full app source audit
- Auth, payments, multi-tenant, file upload code

## Authorization
Static review of code the operator can access — no live exploit required.
Still respect client confidentiality and redaction.

## Workflow

### 1. Scope & context
- Languages/frameworks
- Trust boundaries (internet / internal / library)
- Data sensitivity (PII, credentials, payments)
- Entry points (HTTP, queues, jobs, webhooks)

### 2. Review by class (priority order)
1. **Injection** — SQLi, command, XSS, SSTI, LDAP, path traversal, header/log injection (CWE-89, 78, 79, 22, 94)
2. **Authentication & session** — hardcoded secrets, missing auth, weak JWT/session (CWE-287, 306, 798, 384)
3. **Authorization** — missing checks, IDOR/BOLA, privilege escalation (CWE-639, 285, 862, 863)
4. **Cryptography** — weak algs, hardcoded keys, custom crypto (CWE-327, 328, 321)
5. **Data exposure** — secrets in logs/errors, debug mode, verbose APIs (CWE-200, 209, 532)
6. **Misconfiguration** — CORS, security headers, default creds (CWE-16, 1188)
7. **Deserialization & files** — unsafe pickle/YAML, upload path issues (CWE-502, 434)

### 3. Framework-specific hotspots
- **Express/Next**: SSRF via fetch, mass assignment, CSRF, open redirects
- **Django/Flask**: raw SQL, template autoescape off, DEBUG=True
- **Spring**: SpEL injection, actuator exposure
- **Rails**: strong params gaps, mass assignment
- **Go**: command construction, path join

### 4. Diff-aware mode (PRs)
- Focus changed lines + surrounding controls
- Flag **removed** security checks
- New endpoints must match existing auth patterns

## Output
Findings per `templates/finding.md` / schema. Include confidence and fixed-code sketch when safe.

## Framework map
- OWASP ASVS 4.0.3 (V1–V14 as applicable)
- OWASP Top 10 2021 / 2025 categories
- CWE Top 25

