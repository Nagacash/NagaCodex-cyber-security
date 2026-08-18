# Examples

## End-to-end install test (Hermes / any agent)

### 1. Install (namespaced — required on multi-pack roots)

```bash
git clone https://github.com/Nagacash/NagaCodex-cyber-security.git
cd NagaCodex-cyber-security
export SKILLS_DIR=/opt/data/skills   # Hermes default
./install.sh hermes
./scripts/verify-install.sh "$SKILLS_DIR/naga-codex"
```

**Do not** `cp -r skills/*` into an existing pack directory (e.g. `cybersecurity/`).  
That creates ambiguous basenames. Always use `./install.sh hermes`.

### 2. Load test

```text
skill_view('secure-code-review')
skill_view('llm-top10-review')
```

### 3. Execute test (required for ≥9/10)

```text
Using Naga Codex skill secure-code-review, audit examples/vuln-sample/app.py.
Authorization: static analysis of this owned sample only.
Produce findings with CWE/ASVS and a severity table.
```

Compare against [`sample-report-secure-code-review.md`](sample-report-secure-code-review.md).

### Pass criteria
| Check | Pass |
|-------|------|
| 25 SKILL.md under `naga-codex/` | yes |
| `verify-install.sh` exit 0 | yes |
| skill_view loads without "Ambiguous skill name" | yes |
| secure-code-review finds SQLi + BOLA + secrets + RCE sink | ≥4 critical/high |
