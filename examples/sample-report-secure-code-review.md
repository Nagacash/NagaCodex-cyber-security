# Sample report: secure-code-review on `examples/vuln-sample/app.py`

**Engagement:** NC-SAMPLE-001  
**Posture:** Defensive consulting · static analysis · authorized sample  
**Skill:** `secure-code-review` v1.0.0  
**Frameworks:** OWASP ASVS 4.0.3 · CWE · OWASP API Top 10  

## Gate
- Target: local sample in this repository  
- Authorization: owner-operated training fixture  
- `authorization_confirmed`: true (static only)

## Summary

| Critical | High | Medium | Low | Info |
|----------|------|--------|-----|------|
| 3 | 2 | 1 | 0 | 0 |

## Findings

### SCR-001 — Hardcoded credentials in source
| Field | Value |
|-------|-------|
| **Severity** | critical |
| **CWE** | CWE-798 |
| **ASVS** | V2.10 / V6.4 (secrets) |
| **Location** | `app.py` — `DATABASE_URL`, `AWS_SECRET_ACCESS_KEY` |

**Description:** Production-like database password and cloud secret are embedded in source. Anyone with repo or image access obtains live credentials.

**Evidence (redacted):**
```text
DATABASE_URL = "postgres://admin:[REDACTED]@db.internal:5432/app"
AWS_SECRET_ACCESS_KEY = "[REDACTED]"
```
Note: source password contains `@`, so naive `user:***@host` masks are ambiguous and partial masks can leak characters. Fully redact.

**Remediation:** Remove secrets; load from a secret manager or env injected at runtime; rotate all exposed credentials; add secret scanning in CI.

**Priority:** immediate

---

### SCR-002 — Broken object-level authorization on invoices (BOLA)
| Field | Value |
|-------|-------|
| **Severity** | high |
| **CWE** | CWE-639 |
| **OWASP API** | API1:2023 |
| **Location** | `get_invoice` |

**Description:** Invoice is loaded by `invoice_id` only. `user_id` path param is unused for authorization. Any authenticated (or unauthenticated) caller can read other users’ invoices.

**Remediation:** Enforce `invoice.owner_id == auth.user_id` (or tenant scope) before return; add tests for cross-user access.

**Priority:** immediate

---

### SCR-003 — SQL injection in search
| Field | Value |
|-------|-------|
| **Severity** | critical |
| **CWE** | CWE-89 |
| **ASVS** | V5.3.4 |
| **Location** | `search` — f-string SQL |

**Description:** User input `q` is interpolated into SQL. Enables data theft or DB compromise.

**Remediation:** Parameterized query only, e.g. `LIKE ?` with bound `"%"+q+"%"`; prefer ORM.

**Priority:** immediate

---

### SCR-004 — OS command injection and missing authentication
| Field | Value |
|-------|-------|
| **Severity** | critical |
| **CWE** | CWE-78, CWE-306 |
| **Location** | `admin_run` |

**Description:** `shell=True` executes caller-controlled `cmd` with no authn/authz. Direct RCE.

**Remediation:** Remove endpoint or replace with allowlisted operations; never `shell=True` on user input; require strong admin authn + authz.

**Priority:** immediate

---

### SCR-005 — Debug config exposes secrets and environment
| Field | Value |
|-------|-------|
| **Severity** | high |
| **CWE** | CWE-200 |
| **Location** | `debug_config` |

**Description:** Endpoint returns DB URL, AWS key, and full `os.environ`.

**Remediation:** Delete endpoint in non-dev builds; never return secrets; gate diagnostics behind admin auth and non-production checks.

**Priority:** immediate

---

### SCR-006 — Flask debug server bound to all interfaces
| Field | Value |
|-------|-------|
| **Severity** | medium |
| **CWE** | CWE-489 (related) |
| **Location** | `__main__` — `debug=True`, `host=0.0.0.0` |

**Description:** Debug reloader/pin debugger patterns are unsafe on network-exposed hosts.

**Remediation:** Use production WSGI server; `debug=False`; bind localhost only for local dev.

**Priority:** short_term

---

## Positive observations
- Invoice lookup uses parameterized query for `invoice_id` (good pattern — inconsistent with `search`).
- Sample is clearly labeled as non-deploy training code.

## Roadmap
1. **Immediate:** remove secrets, fix SQLi, remove/disable `admin_run` and `debug_config`, fix BOLA  
2. **Short term:** production runner, authn middleware, secret scanning in CI  
3. **Retest:** re-run `secure-code-review` + `secrets-scan` on this path  

## JSON envelope (abridged)

```json
{
  "schema_version": "1.0.0",
  "engagement": {
    "id": "NC-SAMPLE-001",
    "timestamp": "2026-08-18T00:00:00Z",
    "target": "examples/vuln-sample/app.py",
    "authorization_confirmed": true,
    "tool": "secure-code-review"
  },
  "skill": { "name": "secure-code-review", "version": "1.0.0", "frameworks": ["OWASP-ASVS-4.0.3", "CWE"] },
  "summary": { "critical": 3, "high": 2, "medium": 1, "low": 0, "info": 0 },
  "findings": ["SCR-001", "SCR-002", "SCR-003", "SCR-004", "SCR-005", "SCR-006"]
}
```

---

*This report is the gold-standard “test includes output” artifact for Hermes/agent install verification.*
