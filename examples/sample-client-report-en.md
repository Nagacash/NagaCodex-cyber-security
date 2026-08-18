# Security Assessment Report

**Client:** Naga Codex (internal training sample)  
**Engagement ID:** NC-SAMPLE-001  
**Target:** `examples/vuln-sample/app.py`  
**Date:** 2026-08-18  
**Prepared by:** Naga Codex  
**Classification:** Internal training · Confidential if reused with real assets  
**Posture:** Defensive consulting · static analysis only  

---

## 1. Executive summary

We performed an authorized **static** secure code review of the Naga Codex teaching fixture `examples/vuln-sample/app.py` using the `secure-code-review` skill, then consolidated results with `client-security-report`.

**Overall posture: critical — do not deploy.** The sample intentionally demonstrates multiple high-impact failures. In a real engagement these would block release.

Top risks in business terms:
1. **Credential theft** — database and cloud secrets sit in source and are also exposed via a debug API.
2. **Data breach / fraud** — SQL injection and missing invoice authorization enable bulk data access.
3. **Full server takeover** — an unauthenticated endpoint runs shell commands from the request body.

What is already solid: the invoice lookup uses a parameterized query for the id field (good pattern), and the file is clearly labeled as non-production training code.

**Next 7 days (if this were production code):** rotate every embedded secret, remove RCE and debug routes, fix SQLi and BOLA, add CI secret scanning, then retest.

### Risk snapshot

| Critical | High | Medium | Low | Info |
|----------|------|--------|-----|------|
| 3 | 2 | 1 | 0 | 0 |

## 2. Scope and methodology

- **In scope:** Static analysis of `examples/vuln-sample/app.py` only  
- **Out of scope:** Dynamic testing, network scanning, production systems  
- **Authorization:** Owner-operated teaching fixture; `authorization_confirmed: true` (static only)  
- **Methods:** Manual structured review per Naga Codex `secure-code-review` (ASVS/CWE classes); findings normalized to `schemas/finding.schema.json`  
- **Frameworks:** OWASP ASVS 4.0.3, CWE, OWASP API Top 10:2023, NIST CSF 2.0 (reporting)  
- **Limitations:** Single-file sample; no runtime confirmation; secrets in snippets redacted in client-facing text  

## 3. Key findings

### SCR-001 — Hardcoded credentials in source

| Field | Value |
|-------|-------|
| **Severity** | critical |
| **Status** | open |
| **CWE** | CWE-798 |
| **Location** | `examples/vuln-sample/app.py (DATABASE_URL, AWS_SECRET_ACCESS_KEY)` |

**Description:** Production-like database password and cloud secret are embedded in application source. Anyone with repository, backup, or image access obtains live credentials suitable for data theft and cloud abuse.

**Evidence (redacted):** `DATABASE_URL = "postgres://admin:[REDACTED]@db.internal:5432/app"` — full secret redacted (source password contains `@`; do not use partial masks).

**Business impact:** Full database and cloud account compromise; regulatory exposure if personal data is reachable.

**Remediation:** Remove secrets from source; load from a secret manager or runtime env; rotate all exposed credentials immediately; add secret scanning (gitleaks/trufflehog class) to CI and block merges on hits.

**Priority:** immediate · **Effort:** low


### SCR-002 — Broken object-level authorization on invoices (BOLA)

| Field | Value |
|-------|-------|
| **Severity** | high |
| **Status** | open |
| **CWE** | CWE-639 |
| **Location** | `examples/vuln-sample/app.py — get_invoice` |

**Description:** Invoice records are loaded by invoice_id only. The user_id path parameter is not used for authorization, so any caller who can hit the endpoint may read other users' invoices.

**Business impact:** Confidential financial/customer invoice data leakage across accounts.

**Remediation:** Enforce invoice.owner_id == auth.user_id (or tenant scope) before return; deny with 404/403 on mismatch; add automated cross-user access tests.

**Priority:** immediate · **Effort:** medium


### SCR-003 — SQL injection in product search

| Field | Value |
|-------|-------|
| **Severity** | critical |
| **Status** | open |
| **CWE** | CWE-89 |
| **Location** | `examples/vuln-sample/app.py — search` |

**Description:** User-controlled query parameter q is interpolated into SQL via an f-string. An attacker can alter the query to read, modify, or destroy data.

**Business impact:** Database compromise; potential full application takeover.

**Remediation:** Use parameterized queries only (e.g. LIKE ? with bound value). Prefer an ORM. Add SAST rule for string-built SQL.

**Priority:** immediate · **Effort:** low


### SCR-004 — OS command injection with missing authentication

| Field | Value |
|-------|-------|
| **Severity** | critical |
| **Status** | open |
| **CWE** | CWE-78, CWE-306 |
| **Location** | `examples/vuln-sample/app.py — admin_run` |

**Description:** The admin_run endpoint executes caller-supplied cmd via shell=True with no authentication or authorization. This is direct remote code execution if the service is reachable.

**Business impact:** Complete host compromise; lateral movement into internal networks.

**Remediation:** Remove the endpoint or replace with a fixed allowlist of operations; never use shell=True on user input; require strong admin authentication and authorization; place behind network controls.

**Priority:** immediate · **Effort:** medium


### SCR-005 — Debug config endpoint exposes secrets and environment

| Field | Value |
|-------|-------|
| **Severity** | high |
| **Status** | open |
| **CWE** | CWE-200 |
| **Location** | `examples/vuln-sample/app.py — debug_config` |

**Description:** A debug endpoint returns the database URL, AWS key material, and the full process environment to any caller.

**Business impact:** Credential and configuration theft enabling further compromise.

**Remediation:** Delete the endpoint outside local development; never return secrets; gate any diagnostics behind admin auth and explicit non-production checks.

**Priority:** immediate · **Effort:** low


### SCR-006 — Flask debug server bound to all interfaces

| Field | Value |
|-------|-------|
| **Severity** | medium |
| **Status** | open |
| **CWE** | CWE-489 |
| **Location** | `examples/vuln-sample/app.py — __main__` |

**Description:** The application entrypoint runs Flask with debug=True and host 0.0.0.0, which is unsafe if exposed beyond localhost (debugger and verbose errors).

**Business impact:** Increased attack surface and information leakage if network-exposed.

**Remediation:** Use a production WSGI server (gunicorn/uvicorn); debug=False; bind localhost only for local development.

**Priority:** short_term · **Effort:** low



## 4. Positive observations

- Invoice ID lookup uses a bound parameter (`?`) rather than string concatenation — correct pattern, inconsistently applied elsewhere.
- Module docstring states the code must not be deployed — reduces accidental production use.
- Clear function-level comments map issues to teaching IDs, which speeds remediation tracking in training.

## 5. Prioritized roadmap

| Priority | Action | Owner | Target date |
|----------|--------|-------|-------------|
| immediate (0–7d) | Rotate and remove hardcoded DB/AWS secrets; delete or lock down `admin_run` and `debug_config` | Eng | +7d |
| immediate (0–7d) | Parameterize `search` SQL; enforce invoice ownership checks (BOLA) | Eng | +7d |
| short_term (8–30d) | Replace Flask debug server with production WSGI; `debug=False` | Eng | +30d |
| short_term (8–30d) | Add CI secret scan + SAST gate on SQL/shell sinks | DevSecOps | +30d |
| planned (31–90d) | Authn middleware baseline; tenant isolation tests in CI | Eng | +90d |

## 6. Next steps

1. Remediate all **critical** and **high** findings (or accept risk in writing with expiry — not recommended here).  
2. Schedule retest: re-run `secure-code-review` + `secrets-scan` on the path.  
3. Optional: map residual gaps to GDPR Art. 32 / NIS2 technical measures if personal data would be processed.  
4. Machine-readable bundle: `examples/sample-findings.json`.

---

*Naga Codex — AI management · Cybersecurity · Film · nagacodex.cloud*  
*Defensive consulting sample — not a production assessment of a live client system.*
