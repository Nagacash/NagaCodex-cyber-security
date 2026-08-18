---
name: devsecops-pipeline
description: >
  Design or generate a practical DevSecOps CI security pipeline: SAST, SCA,
  secrets, container scan, and optional DAST gates with severity thresholds.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: devsecops
  frameworks: "OWASP-CICD, SLSA, NIST-SSDF"
---

# DevSecOps Pipeline

## When to use
- "security pipeline", "GitHub Actions security", "shift left"
- Greenfield CI or hardening existing pipelines

## Reference stages
1. **Checkout + build**
2. **Secrets scan** (gitleaks/trufflehog class)
3. **SCA / dependency audit** + SBOM publish
4. **SAST** (language-appropriate)
5. **IaC/container scan** if present
6. **Unit tests**
7. **Optional DAST** on ephemeral env (authorized)
8. **Sign/attest** (supply chain) when mature

## Gate policy (default recommend)
| Severity | PR gate |
|----------|---------|
| Critical secrets | Fail |
| Critical/High CVE in direct prod deps (fixable) | Fail or warn+ticket |
| SAST High+ with high confidence | Fail |
| Medium | Warn |

## Deliverable
- Pipeline YAML sketch for the client's stack (GitHub Actions / GitLab CI)
- Policy doc: what fails the build
- False-positive handling process

## Framework map
- OWASP CI/CD Top 10 concepts
- SLSA level-oriented improvements
- NIST SSDF (high level)

