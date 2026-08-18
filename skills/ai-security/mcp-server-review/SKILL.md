---
name: mcp-server-review
description: >
  Security review of Model Context Protocol (MCP) servers and tool bridges:
  over-permissioning, data exfil paths, supply-chain trust, and prompt-tool
  abuse. Use when building or auditing MCP servers.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: ai-security
  frameworks: "OWASP-LLM-Top-10-2025, OWASP-Agentic-Top-10-2026, CWE"
---

# MCP Server Security Review

## When to use
- "review MCP server", "MCP security", "tool bridge audit"
- Before publishing or installing an MCP server

## Threat model (condensed)
MCP servers expose tools/resources to agents. Risks: credential theft, silent
data exfil, destructive tools, poisoned tool descriptions, confused deputy.

## Checklist

### 1. Permission surface
- Tools should be least privilege
- No blanket filesystem/network/shell without need
- Separate read vs write tools

### 2. Data handling
- Secrets never in tool responses by default
- PII minimization; redaction helpers
- Explicit allowlists for outbound domains

### 3. Trust & supply chain
- Pin dependencies; verify publisher
- Tool descriptions must match behavior (coherence)
- Watch for update diffs that add exfil (Postmark-MCP class incidents)

### 4. Invocation safety
- Dangerous commands (`curl|bash`, reverse shells) blocked
- Path guards for `~/.ssh`, `.env`, cloud cred paths
- Confirm actions for destructive operations

### 5. Authn/authz
- How does the server authenticate to backends?
- Per-tenant isolation if multi-user
- Tokens stored securely; rotation path

## Output
Findings mapped to LLM03/LLM06, ASI02/ASI03/ASI04, CWE as applicable.

