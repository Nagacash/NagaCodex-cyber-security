---
name: iac-container-security
description: >
  Review Infrastructure-as-Code and container definitions (Terraform,
  Kubernetes, Docker, CloudFormation) for misconfigurations and supply-chain
  risks.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: cloud
  frameworks: "CIS-Docker, CIS-Kubernetes, CWE"
---

# IaC & Container Security

## When to use
- Terraform / K8s / Dockerfile review
- "IaC security", "K8s hardening", "Docker security"

## Terraform / CloudFormation hotspots
- `0.0.0.0/0` ingress on SSH/RDP/DB ports
- Public S3/GCS/Azure blob ACLs
- Privileged IAM policies inline
- Missing encryption flags
- Secrets in plain tfvars committed to git

## Kubernetes
- Containers running as root
- Privileged pods / hostNetwork / hostPath abuse
- Missing resource limits
- Wildcard Roles/ClusterRoles
- Secrets as env from plain ConfigMaps
- Admission controls absent (PSS/PSA)

## Dockerfile
- `latest` tags in production
- Secrets in layers (`ENV` password)
- Unnecessary packages / no non-root user
- Missing HEALTHCHECK where relevant

## Method
1. Inventory IaC and container files
2. Pattern review + recommend scanner (Checkov, tfsec, Trivy, KICS) when available
3. Findings with file:line and hardened snippet

## Framework map
- CIS Docker / CIS Kubernetes
- OWASP IaC / Docker guidance
- CWE-250, CWE-668, CWE-1188

