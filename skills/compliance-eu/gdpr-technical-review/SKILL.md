---
name: gdpr-technical-review
description: >
  Technical GDPR (DSGVO) review for systems processing personal data: lawful
  basis awareness, minimization, security of processing (Art. 32), logs,
  retention, and data subject rights enablement. Not legal advice.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: compliance-eu
  frameworks: "GDPR, ISO-27001, NIST-CSF-2.0"
---

# GDPR Technical Review

> **Not legal advice.** Technical control assessment for engineering teams and
> Naga Codex consulting. Clients need qualified counsel for legal determinations.

## When to use
- DACH/EU product handling personal data
- "GDPR", "DSGVO", "Art. 32", "privacy review"

## Technical control areas

| Area | Art. anchors | Engineering checks |
|------|--------------|--------------------|
| Security of processing | Art. 32 | Encryption, access control, resilience, restore testing |
| Data minimization | Art. 5(1)(c) | Collect only needed fields; no surprise PII in logs |
| Storage limitation | Art. 5(1)(e) | Retention TTLs; deletion jobs |
| Integrity/confidentiality | Art. 5(1)(f) | Authn/authz, secrets, tenant isolation |
| Accountability | Art. 5(2) | Audit logs of access to personal data |
| Breach readiness | Art. 33/34 | Detect, notify path, evidence pack |
| DPIA support | Art. 35 | High-risk processing flagged for legal/DPO |

## Workflow
1. Data inventory: what PII, where stored, who accesses, transfers
2. Map flows (collect → store → process → share → delete)
3. Control gaps as findings with GDPR article refs
4. Separate **technical gap** vs **legal determination needed**

## Output
Findings + data-flow summary + priority fixes. Mark legal questions as verify for counsel/DPO.

