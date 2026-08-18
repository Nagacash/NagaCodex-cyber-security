---
name: authorization-gate
description: >
  Mandatory pre-engagement authorization and rules-of-engagement gate for any
  security testing, recon, scanning, or live assessment. Use before pentests,
  bug bounty work, cloud audits, or any active testing. Blocks unauthorized work.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: engagement
  frameworks: "NIST-CSF-2.0, ISO-27001"
---

# Authorization Gate

Required entry point for Naga Codex **defensive consulting** engagements before any live testing.

## When to use
- Before **any** active testing, scanning, or exploitation-adjacent analysis
- Start of every Naga Codex security engagement
- When user says: "pentest", "scan", "hack", "test this host", "recon"

## Hard stop rule
If authorization cannot be confirmed → **do not proceed**. Ask for RoE/SOW/scope.

## Workflow

### 1. Collect proof
Ask for or locate:
- Written authorization (email, SOW, bug-bounty program URL, internal ticket)
- Named client / asset owner
- In-scope assets (domains, IPs, repos, cloud accounts, identities)
- Out-of-scope assets and forbidden techniques
- Testing window and emergency contact
- Data-handling constraints (GDPR, PII, production vs staging)

### 2. Validate scope clarity
Scope must answer:
| Question | Required |
|----------|----------|
| What may be tested? | Yes |
| What must not be touched? | Yes |
| Destructive tests allowed? | Yes (default: no) |
| Social engineering allowed? | Yes (default: no) |
| Data exfil for proof? | Minimal redacted evidence only |

### 3. Record gate result
```yaml
authorization_confirmed: true|false
engagement_id: NC-YYYYMMDD-###
client: ...
scope_in: [...]
scope_out: [...]
forbidden: [dos, phishing-staff, ransomware-sim, ...]
window: ...
evidence_rules: redact-secrets-and-pii
```

### 4. Proceed or stop
- `true` → load the next skill (engagement-kickoff or technical skill)
- `false` → stop and request missing artifacts

## Output
Short gate record + go/no-go. Never invent authorization.

## Framework map
- NIST CSF 2.0: GV.OC, GV.RM
- ISO 27001: A.5.1, A.8.8 (context: authorized testing)

