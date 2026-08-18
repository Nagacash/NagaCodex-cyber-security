# Sicherheitsprüfungsbericht

**Kunde:** Naga Codex (internes Trainings-Sample)  
**Engagement-ID:** NC-SAMPLE-001  
**Zielsystem:** `examples/vuln-sample/app.py`  
**Datum:** 18.08.2026  
**Erstellt von:** Naga Codex  
**Einstufung:** Internes Training · bei realen Assets vertraulich  
**Ausrichtung:** Defensive Consulting · nur statische Analyse  

---

## 1. Management Summary

Im Rahmen eines autorisierten **statischen** Secure-Code-Reviews wurde das Trainings-Sample `examples/vuln-sample/app.py` mit dem Skill `secure-code-review` geprüft und die Ergebnisse mit `client-security-report` verdichtet.

**Gesamtrisiko: kritisch — nicht in Betrieb nehmen.** Das Sample demonstriert absichtlich mehrere schwerwiegende Schwachstellen. In einem echten Mandat wären das Release-Blocker.

Die drei wichtigsten Risiken in Geschäftssprache:
1. **Diebstahl von Zugangsdaten** — Datenbank- und Cloud-Geheimnisse liegen im Quellcode und werden zusätzlich über eine Debug-API ausgegeben.
2. **Datenabfluss / Betrug** — SQL-Injection und fehlende Rechnungs-Autorisierung ermöglichen massenhaften Datenzugriff.
3. **Vollständige Serverübernahme** — ein nicht authentifizierter Endpunkt führt Shell-Befehle aus dem Request aus.

Positiv: Die Rechnungssuche nutzt für die ID einen parametrisierten Query (gutes Muster), und die Datei ist klar als Nicht-Produktion gekennzeichnet.

**Nächste 7 Tage (wäre dies Produktivcode):** alle eingebetteten Secrets rotieren, RCE- und Debug-Routen entfernen, SQLi und BOLA beheben, Secret-Scanning in der CI aktivieren, anschließend Retest.

### Risikolage

| Kritisch | Hoch | Mittel | Niedrig | Info |
|----------|------|--------|---------|------|
| 3 | 2 | 1 | 0 | 0 |

## 2. Umfang und Methodik

- **Im Scope:** Statische Analyse ausschließlich von `examples/vuln-sample/app.py`  
- **Außerhalb des Scopes:** Dynamische Tests, Netzwerk-Scans, Produktivsysteme  
- **Autorisierung:** Eigentümer-betriebenes Lehr-Fixture; `authorization_confirmed: true` (nur statisch)  
- **Methoden:** Strukturiertes Review nach Naga-Codex-Skill `secure-code-review` (ASVS/CWE); Normalisierung gemäß `schemas/finding.schema.json`  
- **Frameworks:** OWASP ASVS 4.0.3, CWE, OWASP API Top 10:2023, NIST CSF 2.0 (Bericht)  
- **Einschränkungen:** Einzeldatei-Sample; keine Laufzeitbestätigung; Secrets in Ausschnitten redigiert  

## 3. Wesentliche Feststellungen

### SCR-001 — Hardcoded credentials in source

| Feld | Wert |
|------|------|
| **Schwere** | critical |
| **Status** | open |
| **CWE** | CWE-798 |
| **Ort** | `examples/vuln-sample/app.py (DATABASE_URL, AWS_SECRET_ACCESS_KEY)` |

**Beschreibung:** Production-like database password and cloud secret are embedded in application source. Anyone with repository, backup, or image access obtains live credentials suitable for data theft and cloud abuse.

**Evidence (redigiert):** `DATABASE_URL = "postgres://admin:[REDACTED]@db.internal:5432/app"` — Geheimnis vollständig schwärzen (Passwort enthält `@`; keine Teilmasken).

**Geschäftliche Auswirkung:** Full database and cloud account compromise; regulatory exposure if personal data is reachable.

**Maßnahme:** Remove secrets from source; load from a secret manager or runtime env; rotate all exposed credentials immediately; add secret scanning (gitleaks/trufflehog class) to CI and block merges on hits.

**Priorität:** immediate · **Aufwand:** low


### SCR-002 — Broken object-level authorization on invoices (BOLA)

| Feld | Wert |
|------|------|
| **Schwere** | high |
| **Status** | open |
| **CWE** | CWE-639 |
| **Ort** | `examples/vuln-sample/app.py — get_invoice` |

**Beschreibung:** Invoice records are loaded by invoice_id only. The user_id path parameter is not used for authorization, so any caller who can hit the endpoint may read other users' invoices.

**Geschäftliche Auswirkung:** Confidential financial/customer invoice data leakage across accounts.

**Maßnahme:** Enforce invoice.owner_id == auth.user_id (or tenant scope) before return; deny with 404/403 on mismatch; add automated cross-user access tests.

**Priorität:** immediate · **Aufwand:** medium


### SCR-003 — SQL injection in product search

| Feld | Wert |
|------|------|
| **Schwere** | critical |
| **Status** | open |
| **CWE** | CWE-89 |
| **Ort** | `examples/vuln-sample/app.py — search` |

**Beschreibung:** User-controlled query parameter q is interpolated into SQL via an f-string. An attacker can alter the query to read, modify, or destroy data.

**Geschäftliche Auswirkung:** Database compromise; potential full application takeover.

**Maßnahme:** Use parameterized queries only (e.g. LIKE ? with bound value). Prefer an ORM. Add SAST rule for string-built SQL.

**Priorität:** immediate · **Aufwand:** low


### SCR-004 — OS command injection with missing authentication

| Feld | Wert |
|------|------|
| **Schwere** | critical |
| **Status** | open |
| **CWE** | CWE-78, CWE-306 |
| **Ort** | `examples/vuln-sample/app.py — admin_run` |

**Beschreibung:** The admin_run endpoint executes caller-supplied cmd via shell=True with no authentication or authorization. This is direct remote code execution if the service is reachable.

**Geschäftliche Auswirkung:** Complete host compromise; lateral movement into internal networks.

**Maßnahme:** Remove the endpoint or replace with a fixed allowlist of operations; never use shell=True on user input; require strong admin authentication and authorization; place behind network controls.

**Priorität:** immediate · **Aufwand:** medium


### SCR-005 — Debug config endpoint exposes secrets and environment

| Feld | Wert |
|------|------|
| **Schwere** | high |
| **Status** | open |
| **CWE** | CWE-200 |
| **Ort** | `examples/vuln-sample/app.py — debug_config` |

**Beschreibung:** A debug endpoint returns the database URL, AWS key material, and the full process environment to any caller.

**Geschäftliche Auswirkung:** Credential and configuration theft enabling further compromise.

**Maßnahme:** Delete the endpoint outside local development; never return secrets; gate any diagnostics behind admin auth and explicit non-production checks.

**Priorität:** immediate · **Aufwand:** low


### SCR-006 — Flask debug server bound to all interfaces

| Feld | Wert |
|------|------|
| **Schwere** | medium |
| **Status** | open |
| **CWE** | CWE-489 |
| **Ort** | `examples/vuln-sample/app.py — __main__` |

**Beschreibung:** The application entrypoint runs Flask with debug=True and host 0.0.0.0, which is unsafe if exposed beyond localhost (debugger and verbose errors).

**Geschäftliche Auswirkung:** Increased attack surface and information leakage if network-exposed.

**Maßnahme:** Use a production WSGI server (gunicorn/uvicorn); debug=False; bind localhost only for local development.

**Priorität:** short_term · **Aufwand:** low



## 4. Positive Beobachtungen

- Parametrisierte Abfrage bei der Rechnungs-ID (`?`) — korrektes Muster, an anderer Stelle nicht durchgängig.
- Modul-Docstring warnt vor Produktivbetrieb.
- Lehr-IDs in Kommentaren erleichtern das Tracking der Behebung im Training.

## 5. Priorisierte Maßnahmenroadmap

| Priorität | Maßnahme | Verantwortung | Zieldatum |
|-----------|----------|---------------|-----------|
| sofort (0–7 Tage) | DB-/AWS-Secrets rotieren und entfernen; `admin_run` und `debug_config` löschen oder absichern | Entwicklung | +7 Tage |
| sofort (0–7 Tage) | SQL in `search` parametrisieren; Besitzprüfung bei Rechnungen (BOLA) | Entwicklung | +7 Tage |
| kurzfristig (8–30 Tage) | Flask-Debug-Server durch produktiven WSGI ersetzen; `debug=False` | Entwicklung | +30 Tage |
| kurzfristig (8–30 Tage) | CI: Secret-Scan + SAST für SQL-/Shell-Senken | DevSecOps | +30 Tage |
| geplant (31–90 Tage) | Authn-Middleware-Basis; Tenant-Isolationstests in der CI | Entwicklung | +90 Tage |

## 6. Nächste Schritte

1. Alle **kritischen** und **hohen** Findings beheben (oder schriftlich mit Ablaufdatum als Risiko akzeptieren — hier nicht empfohlen).  
2. Retest planen: erneut `secure-code-review` + `secrets-scan`.  
3. Optional: Restlücken auf DSGVO Art. 32 / NIS2-Maßnahmen mappen, falls personenbezogene Daten verarbeitet würden.  
4. Maschinenlesbares Bundle: `examples/sample-findings.json`.

---

*Naga Codex — AI-Management · Cybersecurity · Film · nagacodex.cloud*  
*Defensive-Consulting-Sample — keine Produktivprüfung eines Live-Kundensystems.*
