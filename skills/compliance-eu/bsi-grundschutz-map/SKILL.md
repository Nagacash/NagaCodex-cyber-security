---
name: bsi-grundschutz-map
description: >
  Map technical findings and architecture to BSI IT-Grundschutz / German
  federal security methodology concepts for DACH clients and public-sector-
  adjacent work. Consulting mapping aid.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: compliance-eu
  frameworks: "BSI-IT-Grundschutz, ISO-27001, NIST-CSF-2.0"
---

# BSI IT-Grundschutz Mapping

## When to use
- German clients expecting BSI-oriented language
- Public sector / KRITIS-adjacent discussions
- "IT-Grundschutz", "BSI", "Baustein"

## Method
1. Collect findings from technical skills
2. Map each to Grundschutz-oriented building-block themes, e.g.:
   - APP (applications)
   - SYS (IT systems)
   - NET (networks)
   - IND/OPS (operations)
   - ORP/CON (org / concepts) when process gaps
3. Prefer official BSI terminology in DE reports
4. Do not invent Baustein IDs — if unsure, map at theme level and mark verify

## Output
Finding table with BSI theme column + DE remediation wording hooks for `client-security-report`.

## Pair with
- `gdpr-technical-review`
- `nis2-readiness`
- `iso27001-gap`

