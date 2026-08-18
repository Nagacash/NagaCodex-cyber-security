---
name: owasp-web-top10
description: >
  Assess a web application against OWASP Top 10 categories with evidence-based
  findings. Use for web app audits, launch readiness, or mapping existing
  findings to OWASP for client reporting.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: appsec
  frameworks: "OWASP-Top-10, CWE"
---

# OWASP Web Top 10 Assessment

## When to use
- Web application security assessment
- "OWASP Top 10 check"
- Launch / go-live security gate

## Workflow
For each category, seek **evidence of presence or absence**:

| ID | Category | What to look for |
|----|----------|------------------|
| A01 | Broken Access Control | IDOR, missing authz, CORS misconfig, path traversal |
| A02 | Cryptographic Failures | HTTP for sensitive data, weak TLS, poor secrets storage |
| A03 | Injection | SQL/NoSQL/OS/LDAP/template injection, XSS |
| A04 | Insecure Design | Missing threat model, abuse cases, rate limits |
| A05 | Security Misconfiguration | Defaults, stack traces, unnecessary features |
| A06 | Vulnerable Components | Outdated deps with known CVEs |
| A07 | Identification & Auth Failures | Credential stuffing gaps, weak session, missing MFA |
| A08 | Software & Data Integrity | Unsigned updates, insecure CI, unsafe deserialization |
| A09 | Logging & Monitoring Failures | No auth logs, no alerting, log injection |
| A10 | SSRF | User-controlled URLs to internal resources |

## Method
1. Map app surfaces (routes, admin, APIs, uploads)
2. Static review + config review first
3. Authorized dynamic checks only after `authorization-gate`
4. One finding per distinct issue; map to OWASP + CWE

## Output
Category coverage table + findings. Mark categories **Not assessed** if out of scope — never fake coverage.

