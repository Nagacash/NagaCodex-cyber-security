---
name: dependency-sbom
description: >
  Audit third-party dependencies for known vulnerabilities and produce SBOM-
  oriented guidance (CycloneDX/SPDX concepts). Use for SCA, supply-chain
  review, license risk, and release gates.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: appsec
  frameworks: "OWASP-Top-10, SLSA, CycloneDX, SPDX"
---

# Dependency & SBOM Audit

## When to use
- "dependency audit", "CVE in packages", "SBOM"
- Release / supply-chain review
- Customer questionnaire on open-source risk

## Workflow

### 1. Inventory
Detect manifests: `package-lock.json`, `pnpm-lock.yaml`, `yarn.lock`, `requirements.txt`, `poetry.lock`, `go.sum`, `Cargo.lock`, `Gemfile.lock`, `pom.xml`, `build.gradle*`.

### 2. Vulnerability check
Prefer project-native tools when available:
- `npm audit` / `pnpm audit`
- `pip-audit` / `safety`
- `govulncheck`
- OSV / NVD lookups for critical direct deps

### 3. Prioritize
| Factor | Weight |
|--------|--------|
| Reachable from internet-facing code | High |
| Has known exploit / KEV | Critical bump |
| Dev-only dependency | Lower |
| Transitive with no path to runtime | Lower |

### 4. SBOM guidance
Recommend generating CycloneDX or SPDX SBOM in CI. Record:
- Tool + format
- Component name/version/purl
- Known vulns linked to components

### 5. Findings
One finding per high-impact vulnerable component or systemic process gap (no SBOM, no CI audit).

## Framework map
- OWASP A06
- SLSA (provenance concepts)
- CycloneDX / SPDX
- CISA KEV when applicable

