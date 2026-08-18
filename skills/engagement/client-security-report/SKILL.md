---
name: client-security-report
description: >
  Produce a client-ready security assessment report in English and/or German
  using Naga Codex templates. Use when consolidating findings into an executive
  deliverable, audit report, or engagement close-out.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: engagement
  frameworks: "NIST-CSF-2.0"
---

# Client Security Report

## When to use
- End of assessment
- User asks for "report", "executive summary", "Kundenbericht", "Management Summary"
- Need bilingual EN/DE deliverable for DACH clients

## Prerequisites
- Findings in `schemas/finding.schema.json` shape (or Markdown findings)
- Scope and authorization recorded

## Workflow

### 1. Normalize findings
For each finding ensure: id, title, severity, status, description, evidence, remediation, framework refs.
Use `docs/severity-rubric.md`. Sort critical → info.

### 2. Write executive summary (EN)
Answer in 5–8 sentences:
- What was assessed
- Overall risk posture (one clear sentence)
- Top 3 risks in business language
- What is already solid (positives)
- Recommended next 30 days

### 3. Write Management Summary (DE) when needed
Same content, business German — no anglicized jargon wall. Use:
- Kritisch / Hoch / Mittel / Niedrig
- Maßnahme, Risiko, Eintrittswahrscheinlichkeit (qualitative)

### 4. Fill templates
- `templates/report-en.md`
- `templates/report-de.md`
- Per-finding: `templates/finding.md`

### 5. Roadmap table
Group remediations:
| Priority | Window | Items |
|----------|--------|-------|
| immediate | 0–7 days | critical + exploitable high |
| short_term | 8–30 days | remaining high + key medium |
| planned | 31–90 days | medium/low + hardening |

### 6. Quality bar
- No invented CVSS if not calculated — label estimates clearly
- No raw secrets in report
- Confirmed vs verify separated
- Naga Codex closing only if this is a commercial sample; internal reports omit marketing close

## Output
Complete Markdown report(s) + optional JSON findings bundle.

