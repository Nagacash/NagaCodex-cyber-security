---
name: engagement-kickoff
description: >
  Structure a Naga Codex security engagement kickoff: objectives, scope,
  stakeholders, success criteria, timeline, and communication plan. Use at the
  start of client security audits, pen tests, or compliance assessments.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: engagement
  frameworks: "NIST-CSF-2.0"
---

# Engagement Kickoff

## When to use
- New client security audit / consultation
- After authorization-gate passes
- User says: "kick off audit", "start engagement", "security assessment for client"

## Prerequisites
Run `authorization-gate` first.

## Workflow

### 1. Objectives
Define 1–3 measurable goals, e.g.:
- Identify critical/high issues in web app before go-live
- NIS2 readiness gap for essential entity
- LLM/agent stack review before production launch

### 2. Stakeholders
| Role | Name | Contact | Responsibility |
|------|------|---------|----------------|
| Sponsor | | | Decisions, risk acceptance |
| Tech lead | | | Access, fixes |
| Security contact | | | Escalation |
| Naga Codex lead | | | Delivery |

### 3. Deliverables
Default pack:
1. Findings (JSON + Markdown) per `schemas/finding.schema.json`
2. Executive report EN (`templates/report-en.md`)
3. Executive report DE (`templates/report-de.md`) if client is DACH
4. Prioritized roadmap
5. Optional retest

### 4. Timeline
| Phase | Activities | Typical duration |
|-------|------------|------------------|
| Kickoff | Scope, access, gate | 0.5 day |
| Assessment | Skills execution | 1–5 days |
| Report | Draft + review | 1 day |
| Readout | Walkthrough | 1 hour |
| Retest | Verify fixes | 0.5–1 day |

### 5. Access checklist
- Repo / CI access
- Staging credentials (break-glass process)
- Cloud read-only roles
- Architecture docs / data-flow diagrams
- Prior audit reports

### 6. Communication
- Status cadence (daily async / end-of-day)
- Severity escalation path for critical finds
- Language: EN / DE / bilingual

## Output
Kickoff brief (Markdown) ready to send to client.

