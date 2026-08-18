---
name: agentic-top10-review
description: >
  Assess agentic AI systems against OWASP Top 10 for Agentic Applications 2026.
  Use for multi-agent systems, tool-using agents, and autonomous workflows.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: ai-security
  frameworks: "OWASP-Agentic-Top-10-2026, MITRE-ATLAS, NIST-AI-RMF"
---

# OWASP Agentic Top 10 2026 Review

## When to use
- AI agents with tools, memory, or multi-agent orchestration
- "agent security", "rogue agent", "tool misuse"

## Checks (ASI01–ASI10)

| ID | Name | Look for |
|----|------|----------|
| ASI01 | Goal Hijack | Untrusted content can rewrite objectives |
| ASI02 | Tool Misuse | Tools callable outside intended purpose |
| ASI03 | Identity & Privilege Abuse | Agent over-permissioned identities |
| ASI04 | Agentic Supply Chain | Untrusted skills/MCP/tools at runtime |
| ASI05 | Unexpected Code Execution | Model-generated code runs unsandboxed |
| ASI06 | Memory/Context Poisoning | Writable memory without integrity controls |
| ASI07 | Insecure Inter-Agent Comms | No auth/integrity between agents |
| ASI08 | Cascading Failures | No circuit breakers; one bad output fans out |
| ASI09 | Human-Agent Trust Exploit | HITL that can be spoofed or social-engineered |
| ASI10 | Rogue Agents | No kill switch, budget, or step visibility |

## Non-negotiables for production agents
1. External kill switch / interrupt
2. Least-privilege tool allowlists
3. Human approval for irreversible actions (payments, deletes, emails to third parties)
4. Budget/iteration caps
5. Audit log of tool calls

## Output
ASI findings + architecture recommendations.

