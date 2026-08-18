---
name: nis2-readiness
description: >
  NIS2 readiness checklist for essential and important entities: governance,
  risk management, incident reporting posture, supply chain, and technical
  measures. Consulting-oriented gap analysis — not a certification.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: compliance-eu
  frameworks: "NIS2, NIST-CSF-2.0, ISO-27001"
---

# NIS2 Readiness Checklist

> Gap analysis aid for Naga Codex clients. Not a notified-body certification.

## When to use
- EU entity asking about NIS2
- "NIS2", "cyber risk management measures", "incident reporting 24h"

## Domains to assess

### 1. Governance
- Named cyber risk accountability at management level
- Policies approved and communicated
- Training for privileged users

### 2. Risk management measures (technical & organizational)
- Asset inventory
- Access control & MFA for remote/admin
- Cryptography policy
- Vulnerability handling & patch SLAs
- Backup & recovery tested
- Network segmentation for critical systems
- Secure development / change management

### 3. Incident handling
- IR plan exists and is tested
- Early warning / detection capability
- Reporting path aligned to national CSIRT timelines (awareness of 24h early warning concepts)

### 4. Supply chain
- Vendor ICT risk assessment
- Contractual security requirements
- Dependency on critical MSP/cloud documented

### 5. Business continuity
- BC/DR plans for essential services
- Crisis communication

## Scoring
Per control: **in place / partial / missing / not applicable** with evidence.

## Output
NIS2 gap matrix + top 10 remediation actions + management summary (DE available via client-security-report).

