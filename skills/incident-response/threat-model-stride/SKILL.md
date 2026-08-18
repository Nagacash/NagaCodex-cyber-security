---
name: threat-model-stride
description: >
  Build a STRIDE threat model with optional MITRE ATT&CK mapping for a system
  or feature. Use in design reviews, new product launches, and architecture
  changes.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: incident-response
  frameworks: "STRIDE, MITRE-ATT&CK, NIST-CSF-2.0"
---

# Threat Model (STRIDE)

## When to use
- New feature / system design review
- "threat model", "STRIDE", "attack surface"
- Before major architecture changes

## Workflow

### 1. Diagram
- Trust boundaries
- External entities, processes, data stores, data flows
- Assets and their sensitivity

### 2. STRIDE per element
| Letter | Threat | Questions |
|--------|--------|-----------|
| S | Spoofing | Can identity be faked? |
| T | Tampering | Can data/code be altered? |
| R | Repudiation | Can actions be denied? |
| I | Info disclosure | Can data leak? |
| D | DoS | Can availability be hurt cheaply? |
| E | Elevation | Can privileges grow illicitly? |

### 3. Risk rate
Impact × likelihood (qualitative L/M/H). Map top threats to MITRE ATT&CK techniques when clear.

### 4. Mitigations
For each accepted threat: control, owner, residual risk.

## Output
- Data-flow description
- Threat table
- Top 10 mitigations
- Residual risks for sign-off

