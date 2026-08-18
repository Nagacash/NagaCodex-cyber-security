---
name: api-security-review
description: >
  Review REST and GraphQL APIs against OWASP API Security Top 10 2023. Use for
  API audits, BOLA/BFLA hunts, mass assignment, rate limiting, and authz gaps.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: appsec
  frameworks: "OWASP-API-Top-10-2023, CWE"
---

# API Security Review

## When to use
- API-only or API-heavy apps
- "BOLA", "BFLA", "mass assignment", "GraphQL security"
- Microservice / mobile backend review

## Workflow — OWASP API Top 10:2023

| ID | Focus | Checks |
|----|-------|--------|
| API1 | BOLA | Object IDs from client; cross-user access tests (authorized) |
| API2 | Broken Auth | Token validation, refresh, password reset, JWT `alg=none` |
| API3 | BOPLA | Excess data in responses; graph over-fetch |
| API4 | Resource Consumption | Missing pagination/rate limits; costly queries |
| API5 | BFLA | Admin functions callable by low-privilege users |
| API6 | Business Flow | Skip steps, replay, race |
| API7 | SSRF | URL/webhook parameters |
| API8 | Misconfig | Open API docs in prod, verbose errors, CORS * |
| API9 | Inventory | Shadow/zombie endpoints, undocumented versions |
| API10 | Unsafe Consumption | Trusting third-party APIs without validation |

### GraphQL extras
- Introspection in production
- Query depth/complexity limits
- Batching abuse
- Field-level authz

## Output
Findings with endpoint, method, auth context, and exploit scenario (authorized only).

