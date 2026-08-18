# Naga Codex Skill Template

Every skill lives at `skills/<domain>/<skill-name>/SKILL.md` and MUST:

1. Follow [agentskills.io](https://agentskills.io/specification) frontmatter (`name`, `description`; optional `license`, `metadata`)
2. Match directory name to `name`
3. Include keyword-rich `description` (what + when)
4. Reference real framework IDs only
5. Emit findings per `schemas/finding.schema.json` and/or `templates/finding.md`
6. Include authorization gate if any live testing is involved
7. Keep SKILL.md lean; put deep checklists in `references/`

```markdown
---
name: example-skill
description: >
  One paragraph: what it does and when to trigger it. Include keywords
  (audit, OWASP, GDPR, MCP, etc.).
license: MIT
metadata:
  author: naga-codex
  version: "1.0.0"
  domain: appsec
  frameworks: "OWASP-ASVS-4.0.3, CWE"
---

# Title

## When to use
## Authorization (if needed)
## Workflow
## Output
## Framework map
## Common pitfalls
```
