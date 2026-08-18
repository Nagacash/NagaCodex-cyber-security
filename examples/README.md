# Examples

## End-to-end install + orchestrator test (Hermes / any agent)

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
skill_view('client-security-report')
skill_view('full-security-audit')
```

### 3. Execute technical skill (Level 4)

```text
Using Naga Codex skill secure-code-review, audit examples/vuln-sample/app.py.
Authorization: static analysis of this owned sample only.
Produce findings with CWE/ASVS and a severity table.
```

Compare against [`sample-report-secure-code-review.md`](sample-report-secure-code-review.md).

### 4. Close orchestrator loop (Level 5) — client reports

```text
Using client-security-report, turn the SCR-001..006 findings from the vuln-sample
review into bilingual client deliverables (EN + DE). Use templates/report-en.md
and templates/report-de.md. Include roadmap and redacted evidence.
```

Gold standard outputs:

| Artifact | Path |
|----------|------|
| Findings JSON | [`sample-findings.json`](sample-findings.json) |
| Technical review | [`sample-report-secure-code-review.md`](sample-report-secure-code-review.md) |
| Client report EN | [`sample-client-report-en.md`](sample-client-report-en.md) |
| Client report DE | [`sample-client-report-de.md`](sample-client-report-de.md) |

### Pass criteria

| Level | Check | Pass |
|-------|-------|------|
| L1 | 25 SKILL.md under `naga-codex/` | yes |
| L2 | `verify-install.sh` exit 0 | yes |
| L3 | skill_view without "Ambiguous skill name" | yes |
| L4 | secure-code-review finds secrets + SQLi + BOLA + RCE sink | ≥4 critical/high |
| L5 | client-security-report produces EN + DE with roadmap | matches gold samples |

**Note:** These are prompt-instruction skills, not a CLI. “Execution” means the agent applies the methodology; the gold files show expected structure and evidence quality.
