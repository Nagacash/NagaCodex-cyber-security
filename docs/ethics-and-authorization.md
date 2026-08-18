# Ethics, Authorization & Scope Gate

**Naga Codex Cyber Security** skills are for authorized security work only:
defensive audits, client engagements with written scope, CTF/lab environments,
and internal hardening. They are not a weapon kit.

## Mandatory gate (every offensive, recon, or live-test skill)

Before any active testing, scanning, or exploitation-adjacent analysis, the agent MUST:

1. Confirm **written authorization** exists (RoE, SOW, bug-bounty program, or lab ownership).
2. Confirm **in-scope targets** (hosts, apps, repos, cloud accounts, identities).
3. Confirm **out-of-scope** and **forbidden techniques** (DoS, social engineering of staff, data exfil beyond evidence needs).
4. Confirm **data handling** (PII minimization, redaction in reports, no secrets in tickets).
5. If any item is missing → **STOP**, ask the operator, do not proceed.

Set `engagement.authorization_confirmed: true` in finding JSON only after the gate passes.

## Never do

- Attack systems without explicit authorization
- Ship or generate ready-to-fire exploit PoCs for unauthorized targets
- Exfiltrate production data "to prove impact" beyond minimal redacted evidence
- Bypass rate limits / availability controls as a default technique
- Ignore client legal constraints (GDPR, works council, sector rules)

## Always do

- Prefer read-only / static analysis first
- Minimize data collection; redact secrets and PII in all outputs
- Map findings to real framework IDs (CWE, OWASP, NIST, MITRE) — never invent control numbers
- Separate **confirmed** vs **verify** findings
- Produce remediation that a developer can implement

## Responsible disclosure

If a vulnerability is found outside a formal engagement, follow coordinated disclosure norms and the client's / vendor's published process. Do not dump details publicly without consent.
