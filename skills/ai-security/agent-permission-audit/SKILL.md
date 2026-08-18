---
name: agent-permission-audit
description: >
  Audit AI agent identities, tool allowlists, secrets access, and human-in-
  the-loop controls. Use for Hyperagent, Claude Code, custom agents, or
  automation bots before production.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: ai-security
  frameworks: "OWASP-Agentic-Top-10-2026, NIST-AI-RMF, NIST-SP-800-207"
---

# Agent Permission Audit

## When to use
- Hardening an agent before production
- "least privilege agent", "agent IAM", "HITL review"

## Workflow

### 1. Inventory
List: agent identities, connected integrations, tools, memories, schedules, data sources.

### 2. Privilege map
| Capability | Needed? | Risk if abused | Control |
|------------|---------|----------------|---------|
| Send email/Slack | | Impersonation, spam, exfil | allowlist + approval |
| Code exec | | RCE, lateral movement | sandbox |
| Browser | | CSRF on logged-in sessions | isolate profiles |
| Cloud admin | | Account takeover | remove / break-glass only |
| Secret read | | Credential theft | scoped secrets |

### 3. Control checks
- [ ] Tool allowlist (not open-ended)
- [ ] Approval for irreversible actions
- [ ] Budget / rate / iteration limits
- [ ] Audit logging of tool calls
- [ ] Kill switch / disable path
- [ ] No standing cloud admin credentials
- [ ] Separate prod vs dev agents

### 4. Findings
Any standing high privilege without business need → High/Critical.

## Framework map
- ASI02, ASI03, ASI09, ASI10
- LLM06
- NIST AI RMF Manage/Govern
- Zero Trust (NIST SP 800-207 concepts)

