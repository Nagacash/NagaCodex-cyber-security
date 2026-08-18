---
name: cloud-security-review
description: >
  Cloud security review patterns for AWS, Azure, and GCP focusing on IAM,
  public exposure, logging, encryption, and network segmentation. Authorized
  read-oriented assessment.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: cloud
  frameworks: "CIS-Benchmarks, NIST-CSF-2.0, MITRE-ATT&CK"
---

# Cloud Security Review

## Authorization
Requires `authorization-gate` and least-privilege **read** access to the target accounts.

## When to use
- AWS/Azure/GCP posture review
- "cloud audit", "public bucket", "IAM review"

## Universal control areas

### 1. Identity
- Root/break-glass protected; MFA on privileged users
- No long-lived access keys where federation possible
- Overly broad roles (`*`, Admin) on workloads

### 2. Public exposure
- Storage public access blocks
- Security groups / NSGs 0.0.0.0/0 on sensitive ports
- Public snapshots/images/AMIs unintended

### 3. Logging & detection
- Cloud audit logs enabled and retained
- Critical write events alerted
- Central log immutability where required

### 4. Encryption & keys
- Data at rest encryption defaults
- CMKs with tight key policies
- Secrets not in plaintext env/userdata

### 5. Network
- Private subnets for data stores
- Egress control for sensitive workloads

## Provider anchors (use official benchmarks)
- CIS AWS Foundations
- CIS Azure Foundations
- CIS GCP Foundations

## Output
Findings with resource ID, region, risk, fix. Prefer evidence from config exports over speculation.

