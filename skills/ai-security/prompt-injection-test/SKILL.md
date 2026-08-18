---
name: prompt-injection-test
description: >
  Systematic prompt-injection and untrusted-content testing for LLM and RAG
  systems using structured attack classes. Authorized testing only.
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: ai-security
  frameworks: "OWASP-LLM-Top-10-2025, MITRE-ATLAS"
---

# Prompt Injection Testing

## Authorization
**Requires `authorization-gate`.** Only test systems you own or are paid to test.

## When to use
- "test prompt injection", "jailbreak test", "RAG injection"
- Pre-production LLM red team (authorized)

## Method (defensive evaluation)

### 1. Trust boundaries
Map: user input, retrieved docs, tools results, uploaded files, emails — anything entering the model.

### 2. Attack classes (test, don't weaponize broadly)
| Class | Intent |
|-------|--------|
| Direct injection | Override system instructions |
| Indirect injection | Malicious content in retrieved/uploaded data |
| Tool inducement | Trick agent into abusive tool calls |
| Data exfil | Coax secrets from system prompt/tools |
| Goal hijack | Change agent objective mid-run |

### 3. For each class
- Attempt **minimal** proof on in-scope staging
- Record prompt/context class (not a public exploit kit dump)
- Note whether guardrails held
- Severity by impact (read-only leak vs privileged action)

### 4. Defenses to recommend
- Separate untrusted content with clear delimiters + untrusted labels
- No privileged tools on raw retrieved content without sanitization
- Output encoding to sinks
- Allowlisted tools; confirm high-risk actions
- Continuous eval set of injection cases in CI

## Output
Findings with attack class, whether blocked, residual risk, fixes.
Map to LLM01, PIPE-style applied gaps, ATLAS prompt-injection techniques where known.

