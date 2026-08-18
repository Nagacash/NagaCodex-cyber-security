---
name: incident-triage
description: >
  Security incident triage following NIST SP 800-61 style phases: identify,
  contain, eradicate guidance, recover, lessons learned. Use for suspected
  breaches, malware alerts, and client IR retainers.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: incident-response
  frameworks: "NIST-SP-800-61, MITRE-ATT&CK, GDPR"
---

# Incident Triage

## When to use
- Suspected compromise, ransomware, account takeover, data leak
- "incident", "IR", "breach triage", "SOC alert"

## Priorities (in order)
1. Protect human safety (if applicable)
2. Contain spread
3. Preserve evidence
4. Eradicate & recover
5. Communicate (legal/PR as required)

## Workflow

### 1. Identify
- What fired? (alert, user report, anomaly)
- Systems/users affected
- UTC timeline start
- Data sensitivity involved

### 2. Initial severity
| Tier | Example |
|------|---------|
| P1 | Active ransomware, confirmed data exfil, domain admin compromise |
| P2 | Malware on endpoint, limited account compromise |
| P3 | Suspicious login blocked, phishing without credential use |

### 3. Contain (authorized)
- Isolate hosts / revoke sessions / rotate keys
- Block IOCs at edge
- **Do not** destroy evidence (avoid hasty reimage before capture)

### 4. Evidence essentials
- Time-synced logs
- Disk/memory capture policy per severity
- Chain of custody notes

### 5. Eradicate & recover guidance
- Remove persistence; patch entry vector
- Rebuild from known-good when needed
- Heightened monitoring period

### 6. Comms
- Internal stakeholdes
- GDPR Art. 33 assessment trigger if personal data
- Customer notification decision with counsel

## Output
Incident ticket brief: summary, severity, timeline, actions taken, next steps, evidence index.

