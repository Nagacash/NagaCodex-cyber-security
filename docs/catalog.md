# Skill Catalog
**25 skills** across **7 domains**.

## `ai-security`
| Skill | Description | Frameworks |
|-------|-------------|------------|
| [`agent-permission-audit`](../skills/ai-security/agent-permission-audit/) | Audit AI agent identities, tool allowlists, secrets access, and human-in- the-loop controls. Use for Hyperagent, Claude Code, custom agents, or automation bo... | OWASP-Agentic-Top-10-2026, NIST-AI-RMF, NIST-SP-800-207 |
| [`agentic-top10-review`](../skills/ai-security/agentic-top10-review/) | Assess agentic AI systems against OWASP Top 10 for Agentic Applications 2026. Use for multi-agent systems, tool-using agents, and autonomous workflows. | OWASP-Agentic-Top-10-2026, MITRE-ATLAS, NIST-AI-RMF |
| [`llm-top10-review`](../skills/ai-security/llm-top10-review/) | Assess LLM applications against OWASP Top 10 for LLM Applications 2025. Use for chatbots, RAG apps, copilots, and any system that prompts a model. | OWASP-LLM-Top-10-2025, NIST-AI-RMF, MITRE-ATLAS |
| [`mcp-server-review`](../skills/ai-security/mcp-server-review/) | Security review of Model Context Protocol (MCP) servers and tool bridges: over-permissioning, data exfil paths, supply-chain trust, and prompt-tool abuse. Us... | OWASP-LLM-Top-10-2025, OWASP-Agentic-Top-10-2026, CWE |
| [`prompt-injection-test`](../skills/ai-security/prompt-injection-test/) | Systematic prompt-injection and untrusted-content testing for LLM and RAG systems using structured attack classes. Authorized testing only. | OWASP-LLM-Top-10-2025, MITRE-ATLAS |

## `appsec`
| Skill | Description | Frameworks |
|-------|-------------|------------|
| [`api-security-review`](../skills/appsec/api-security-review/) | Review REST and GraphQL APIs against OWASP API Security Top 10 2023. Use for API audits, BOLA/BFLA hunts, mass assignment, rate limiting, and authz gaps. | OWASP-API-Top-10-2023, CWE |
| [`dependency-sbom`](../skills/appsec/dependency-sbom/) | Audit third-party dependencies for known vulnerabilities and produce SBOM- oriented guidance (CycloneDX/SPDX concepts). Use for SCA, supply-chain review, lic... | OWASP-Top-10, SLSA, CycloneDX, SPDX |
| [`owasp-web-top10`](../skills/appsec/owasp-web-top10/) | Assess a web application against OWASP Top 10 categories with evidence-based findings. Use for web app audits, launch readiness, or mapping existing findings... | OWASP-Top-10, CWE |
| [`secrets-scan`](../skills/appsec/secrets-scan/) | Detect hardcoded secrets, API keys, tokens, and credentials in source, config, CI, and history. Use before commits, releases, or client handoff. | CWE, OWASP-Top-10, NIST-SP-800-57 |
| [`secure-code-review`](../skills/appsec/secure-code-review/) | Structured security code review against OWASP ASVS and CWE Top 25. Use for PR review, module audits, pre-merge gates, or full application source review. Cove... | OWASP-ASVS-4.0.3, OWASP-Top-10, CWE |
| [`security-headers-tls`](../skills/appsec/security-headers-tls/) | Audit HTTP security headers and TLS configuration for web apps and APIs. Use for CSP, HSTS, cookie flags, CORS, and TLS baseline reviews. | OWASP-ASVS-4.0.3, CWE |

## `cloud`
| Skill | Description | Frameworks |
|-------|-------------|------------|
| [`cloud-security-review`](../skills/cloud/cloud-security-review/) | Cloud security review patterns for AWS, Azure, and GCP focusing on IAM, public exposure, logging, encryption, and network segmentation. Authorized read-orien... | CIS-Benchmarks, NIST-CSF-2.0, MITRE-ATT&CK |
| [`iac-container-security`](../skills/cloud/iac-container-security/) | Review Infrastructure-as-Code and container definitions (Terraform, Kubernetes, Docker, CloudFormation) for misconfigurations and supply-chain risks. | CIS-Docker, CIS-Kubernetes, CWE |

## `compliance-eu`
| Skill | Description | Frameworks |
|-------|-------------|------------|
| [`bsi-grundschutz-map`](../skills/compliance-eu/bsi-grundschutz-map/) | Map technical findings and architecture to BSI IT-Grundschutz / German federal security methodology concepts for DACH clients and public-sector- adjacent wor... | BSI-IT-Grundschutz, ISO-27001, NIST-CSF-2.0 |
| [`gdpr-technical-review`](../skills/compliance-eu/gdpr-technical-review/) | Technical GDPR (DSGVO) review for systems processing personal data: lawful basis awareness, minimization, security of processing (Art. 32), logs, retention, ... | GDPR, ISO-27001, NIST-CSF-2.0 |
| [`iso27001-gap`](../skills/compliance-eu/iso27001-gap/) | ISO/IEC 27001:2022 high-level gap assessment against Annex A theme groups for SMEs and mid-market clients. Produces a prioritized ISMS gap list. | ISO-27001-2022, NIST-CSF-2.0 |
| [`nis2-readiness`](../skills/compliance-eu/nis2-readiness/) | NIS2 readiness checklist for essential and important entities: governance, risk management, incident reporting posture, supply chain, and technical measures.... | NIS2, NIST-CSF-2.0, ISO-27001 |

## `devsecops`
| Skill | Description | Frameworks |
|-------|-------------|------------|
| [`devsecops-pipeline`](../skills/devsecops/devsecops-pipeline/) | Design or generate a practical DevSecOps CI security pipeline: SAST, SCA, secrets, container scan, and optional DAST gates with severity thresholds. | OWASP-CICD, SLSA, NIST-SSDF |
| [`full-security-audit`](../skills/devsecops/full-security-audit/) | Orchestrate an end-to-end Naga Codex security audit by chaining the right skills for the target (code, API, cloud, AI, compliance) and producing a unified cl... | NIST-CSF-2.0, OWASP, MITRE-ATT&CK, GDPR, NIS2 |

## `engagement`
| Skill | Description | Frameworks |
|-------|-------------|------------|
| [`authorization-gate`](../skills/engagement/authorization-gate/) | Mandatory pre-engagement authorization and rules-of-engagement gate for any security testing, recon, scanning, or live assessment. Use before pentests, bug b... | NIST-CSF-2.0, ISO-27001 |
| [`client-security-report`](../skills/engagement/client-security-report/) | Produce a client-ready security assessment report in English and/or German using Naga Codex templates. Use when consolidating findings into an executive deli... | NIST-CSF-2.0 |
| [`engagement-kickoff`](../skills/engagement/engagement-kickoff/) | Structure a Naga Codex security engagement kickoff: objectives, scope, stakeholders, success criteria, timeline, and communication plan. Use at the start of ... | NIST-CSF-2.0 |

## `incident-response`
| Skill | Description | Frameworks |
|-------|-------------|------------|
| [`incident-triage`](../skills/incident-response/incident-triage/) | Security incident triage following NIST SP 800-61 style phases: identify, contain, eradicate guidance, recover, lessons learned. Use for suspected breaches, ... | NIST-SP-800-61, MITRE-ATT&CK, GDPR |
| [`mitre-attack-map`](../skills/incident-response/mitre-attack-map/) | Map observations, alerts, or findings to MITRE ATT&CK tactics and techniques for detection engineering, IR narratives, and client reporting. | MITRE-ATT&CK, MITRE-D3FEND |
| [`threat-model-stride`](../skills/incident-response/threat-model-stride/) | Build a STRIDE threat model with optional MITRE ATT&CK mapping for a system or feature. Use in design reviews, new product launches, and architecture changes. | STRIDE, MITRE-ATT&CK, NIST-CSF-2.0 |
