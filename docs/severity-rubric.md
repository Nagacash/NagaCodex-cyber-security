# Severity Rubric

Use this rubric consistently across all Naga Codex skills.

| Severity | Definition | Typical response |
|----------|------------|------------------|
| **critical** | Direct, reliable compromise of confidentiality/integrity/availability of high-value assets; remote code exec, auth bypass to admin, mass PII exposure, full tenant escape | Fix immediately; block release |
| **high** | Significant risk with realistic exploit path; privilege escalation, sensitive data exposure, missing auth on sensitive functions, prompt-injection → privileged tool | Fix this sprint |
| **medium** | Meaningful weakness requiring preconditions or limited blast radius; incomplete validation, verbose errors with sensitive data, weak session config | Plan fix ≤ 30 days |
| **low** | Defense-in-depth gap, hard-to-exploit, or limited impact | Backlog |
| **info** | Observation, hygiene, positive control, or documentation gap | Note only |

## Adjustments

- **Production + internet-facing** → default one notch up when impact is real
- **Internal / non-prod / throwaway scripts** → consumption and hygiene issues one notch down; injection and privileged-action issues stay
- **Accepted risk** requires named owner + expiry date
- Prefer **verify** status over inventing certainty when evidence is incomplete
