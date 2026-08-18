---
name: mitre-attack-map
description: >
  Map observations, alerts, or findings to MITRE ATT&CK tactics and techniques
  for detection engineering, IR narratives, and client reporting.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: incident-response
  frameworks: "MITRE-ATT&CK, MITRE-D3FEND"
---

# MITRE ATT&CK Mapping

## When to use
- Need ATT&CK IDs on findings or IR timeline
- Detection coverage discussion
- "map to ATT&CK", "TTP"

## Rules
- Use **real** technique IDs only (e.g., T1059, T1078). Never invent.
- If unsure, map at **tactic** level and mark verify
- Prefer Enterprise matrix unless Mobile/ICS clearly applies

## Workflow
1. Extract attacker-relevant behaviors from evidence
2. Assign tactic (initial access, execution, persistence, …)
3. Assign technique/sub-technique when evidence supports
4. Note detection gaps (no log source for technique)
5. Suggest defensive detections (high level) and D3FEND-style countermeasure categories when helpful

## Output
Table: behavior → tactic → technique ID → evidence → detection status.

