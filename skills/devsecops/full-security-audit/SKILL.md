---
name: full-security-audit
description: >
  Orchestrate an end-to-end Naga Codex **defensive consulting** security audit by
  chaining the right skills for the target and producing a unified client report.
  Use for authorized full assessments — not offensive campaigns.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: devsecops
  frameworks: "NIST-CSF-2.0, OWASP, MITRE-ATT&CK, GDPR, NIS2"
---

# Full Security Audit (Defensive Consulting Orchestrator)

## Posture
**Defensive consulting only.** Authorized scope, client-ready remediation, no exploit weaponization.

## When to use
- "full security audit", "defensive security assessment", "launch review", "hardening audit"
- Naga Codex **defensive consulting** engagements needing multi-domain coverage
- Not for unauthorized or purely offensive red-team operations

## Workflow

### Phase 0 — Gate & kickoff
1. `authorization-gate`
2. `engagement-kickoff`
3. Classify target types: web, API, mobile, cloud, LLM/agent, compliance-only

### Phase 1 — Technical (pick applicable)
| If target has… | Run |
|----------------|-----|
| Source code | `secure-code-review`, `secrets-scan`, `dependency-sbom` |
| Web UI | `owasp-web-top10`, `security-headers-tls` |
| API | `api-security-review` |
| Cloud | `cloud-security-review`, `iac-container-security` |
| LLM/RAG | `llm-top10-review`, `prompt-injection-test` (authz) |
| Agents/MCP | `agentic-top10-review`, `mcp-server-review`, `agent-permission-audit` |
| CI | `devsecops-pipeline` |

### Phase 2 — Risk & design
- `threat-model-stride` for new or complex systems
- `mitre-attack-map` for offensive observations

### Phase 3 — Compliance (DACH/EU as needed)
- `gdpr-technical-review`
- `nis2-readiness` / `iso27001-gap` / `bsi-grundschutz-map`

### Phase 4 — Consolidate
1. Deduplicate findings (same root cause → one finding)
2. Apply `docs/severity-rubric.md`
3. `client-security-report` (EN + DE if DACH)

## Quality bar
- Authorization recorded
- Evidence for every non-info finding
- No invented framework IDs
- Clear roadmap
- Retest offer defined

## Output
Single engagement bundle: JSON findings + EN/DE reports + roadmap.

