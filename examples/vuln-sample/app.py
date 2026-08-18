"""
Naga Codex — intentionally vulnerable SAMPLE for defensive skill testing.
DO NOT deploy. Local authorized training only.
"""
from flask import Flask, request, jsonify
import sqlite3
import os
import subprocess

app = Flask(__name__)

# SCR-001: hardcoded production-like secret (CWE-798)
DATABASE_URL = "postgres://admin:P@ssw0rd123@db.internal:5432/app"
AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

def get_db():
    return sqlite3.connect("app.db")

@app.get("/users/<user_id>/invoices/<invoice_id>")
def get_invoice(user_id, invoice_id):
    """
    SCR-002: Broken object-level authorization (CWE-639 / BOLA)
    Any caller can fetch any invoice by ID — no check that invoice belongs to user.
    """
    db = get_db()
    row = db.execute(
        "SELECT * FROM invoices WHERE id = ?",
        (invoice_id,),
    ).fetchone()
    return jsonify({"invoice": row})

@app.get("/search")
def search():
    """
    SCR-003: SQL injection via string format (CWE-89)
    """
    q = request.args.get("q", "")
    db = get_db()
    # vulnerable on purpose
    rows = db.execute(f"SELECT * FROM products WHERE name LIKE '%{q}%'").fetchall()
    return jsonify({"results": rows})

@app.post("/admin/run")
def admin_run():
    """
    SCR-004: OS command injection + missing authn (CWE-78, CWE-306)
    """
    cmd = request.json.get("cmd", "id")
    output = subprocess.check_output(cmd, shell=True, text=True)
    return jsonify({"output": output})

@app.get("/debug/config")
def debug_config():
    """
    SCR-005: Sensitive data exposure (CWE-200)
    """
    return jsonify({
        "database_url": DATABASE_URL,
        "aws_key": AWS_SECRET_ACCESS_KEY,
        "env": dict(os.environ),
    })

if __name__ == "__main__":
    # SCR-006: debug mode in what looks like a server entrypoint (CWE-489 class)
    app.run(host="0.0.0.0", port=5000, debug=True)
