# Hermes install guide

Naga Codex Cyber Security on a Hermes box (`SKILLS_DIR=/opt/data/skills`).

## Correct install

```bash
git clone https://github.com/Nagacash/NagaCodex-cyber-security.git
cd NagaCodex-cyber-security
./install.sh hermes
# -> /opt/data/skills/naga-codex/<domain>/<skill>/SKILL.md
./scripts/verify-install.sh /opt/data/skills/naga-codex
```

Layout:

```
/opt/data/skills/
  naga-codex/                 # our namespace only
    appsec/secure-code-review/
    ai-security/llm-top10-review/
    ...
    INSTALL_MANIFEST.txt
  cybersecurity/              # OTHER pack — never write here
  omh-/...
```

## What went wrong in the first field install (lesson learned)

1. A raw `cp` of domain folders into a **pre-existing** `cybersecurity/` pack  
2. Every Naga skill basename then existed in **two** places  
3. Hermes `skill_view` returned **Ambiguous skill name**  
4. Fix: delete only the stray Naga domain dirs (by install mtime) from `cybersecurity/`; keep the namespaced tree under `naga-codex/`

The installer now **defaults Hermes to namespaced layout** and refuses to treat a foreign pack dir as the install root.

## Verification ladder

| Level | Command / action | Proves |
|-------|------------------|--------|
| 1 Files | `find $SKILLS_DIR/naga-codex -name SKILL.md \| wc -l` → 25 | on disk |
| 2 Unique | `./scripts/verify-install.sh ...` | no basename dups in tree |
| 3 Load | `skill_view('secure-code-review')` | loader resolves |
| 4 Execute | audit `examples/vuln-sample/app.py` | skill **works** |
| 5 Report | `client-security-report` → EN + DE | orchestrator loop closed |

Level 4–5 samples:

- [`examples/sample-report-secure-code-review.md`](../examples/sample-report-secure-code-review.md)
- [`examples/sample-findings.json`](../examples/sample-findings.json)
- [`examples/sample-client-report-en.md`](../examples/sample-client-report-en.md)
- [`examples/sample-client-report-de.md`](../examples/sample-client-report-de.md)

## Residual non-Naga issues

Duplicate `omh-deep-research` / `omh-ralplan` names (root + `omh/`) are **pre-existing** and unrelated. Deduplicate separately if desired.
