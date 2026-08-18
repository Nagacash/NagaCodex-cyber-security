# Hyperagent adapter

Use this **defensive consulting** pack inside Hyperagent as a **concept skill** (documentation + workflows).

Posture: authorized audits, hardening, compliance, IR — not offensive tooling.

## Option A — Point the agent at the repo
1. Clone or pin this repository in the workspace.
2. Tell the agent: "Use Naga Codex Cyber Security skills from ./skills"
3. Prefer orchestrator: `skills/devsecops/full-security-audit/SKILL.md`

## Option B — Import key SKILL.md bodies
Create a Hyperagent skill whose documentation concatenates:
- docs/ethics-and-authorization.md
- docs/severity-rubric.md
- skills/devsecops/full-security-audit/SKILL.md
- plus domain skills needed for the engagement

## Option C — Marketplace / Learning skill
Register skill name: `naga-codex-cyber-security`  
whenToUse: security audits, pentest scoping, OWASP/LLM/MCP reviews, GDPR/NIS2, IR triage, client security reports (EN/DE)
