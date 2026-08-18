---
name: security-headers-tls
description: >
  Audit HTTP security headers and TLS configuration for web apps and APIs.
  Use for CSP, HSTS, cookie flags, CORS, and TLS baseline reviews.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: appsec
  frameworks: "OWASP-ASVS-4.0.3, CWE"
---

# Security Headers & TLS Audit

## When to use
- "security headers", "CSP", "HSTS", "TLS check"
- Hardening web frontends and APIs

## Authorization
Passive header/TLS observation against in-scope URLs only after gate if live.

## Header checklist
| Header | Expectation |
|--------|-------------|
| `Content-Security-Policy` | Present, not `unsafe-inline` without justification |
| `Strict-Transport-Security` | long max-age; includeSubDomains when correct |
| `X-Content-Type-Options` | `nosniff` |
| `Referrer-Policy` | restrictive (e.g. `strict-origin-when-cross-origin`) |
| `Permissions-Policy` | disable unused powerful features |
| `X-Frame-Options` / CSP `frame-ancestors` | clickjacking defense |
| Cookies | `Secure`, `HttpOnly`, appropriate `SameSite` |

## CORS
- `Access-Control-Allow-Origin: *` with credentials = High
- Reflecting arbitrary Origin = High

## TLS baseline
- No SSLv3/TLS1.0/1.1 for public services
- Prefer TLS1.2+ with modern ciphers
- Valid certificate chain; watch for mixed content

## Output
Findings with current vs recommended header values.

