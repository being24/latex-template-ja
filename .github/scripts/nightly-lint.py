"""Publish one persistent textlint report; never auto-fix source files."""
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
from urllib.parse import quote
import xml.etree.ElementTree as ET

MARKER = "<!-- nightly-textlint-report:v1 -->"
TITLE = "Nightly textlint report"


def gh(*args):
    return subprocess.check_output(["gh", *args], text=True)


def issue():
    items = json.loads(gh("issue", "list", "--state", "all", "--search",
                          '"Nightly textlint report" in:title', "--limit", "100",
                          "--json", "number,title,body,state,author"))
    matches = [i for i in items if i["title"] == TITLE and MARKER in i["body"]
               and i.get("author", {}).get("login") in
               ("github-actions", "github-actions[bot]", "app/github-actions")]
    if len(matches) > 1:
        raise RuntimeError("Multiple bot-owned nightly reports; resolve duplicates first")
    return matches[0] if matches else None


def prepare():
    # Hash tracked inputs, including settings and this workflow, not PDFs or build artifacts.
    tracked = subprocess.check_output(["git", "ls-files", "-z", "--", "main.tex",
        "sections", "package.json", "package-lock.json", ".github/workflows/lint.yaml",
        ".github/scripts/nightly-lint.py"]).split(b"\0")
    h = hashlib.sha256()
    for raw in sorted(filter(None, tracked)):
        path = Path(os.fsdecode(raw))
        if path.parts[0] == "sections" and path.suffix != ".tex":
            continue
        h.update(raw + b"\0" + hashlib.sha256(path.read_bytes()).digest())
    digest = h.hexdigest()
    old = issue()
    run = os.environ.get("FORCE") == "true" or not old or (
        f"<!-- input:{digest} -->" not in old["body"])
    with open(os.environ["GITHUB_OUTPUT"], "a") as f:
        print(f"run={str(run).lower()}\nhash={digest}", file=f)
    print("Lint required" if run else "No input changes; skipping lint")


def report():
    # Keep stdout separate from stderr; malformed or missing XML is a CI error.
    result = subprocess.run(["npm", "run", "--silent", "lint-style", "--",
                             "main.tex", "sections"], capture_output=True, text=True)
    if result.stderr:
        print(result.stderr, file=sys.stderr)
    try:
        root = ET.fromstring(result.stdout)
    except ET.ParseError as exc:
        raise RuntimeError("textlint did not return valid Checkstyle XML") from exc
    if root.tag != "checkstyle":
        raise RuntimeError("Unexpected textlint output")
    repo = os.environ["GH_REPO"]
    branch = quote(os.environ["DEFAULT_BRANCH"], safe="")
    sha = gh_sha()
    findings = []
    for f in root.findall("file"):
        path = Path(f.attrib["name"]).resolve().relative_to(Path.cwd().resolve()).as_posix()
        for error in f.findall("error"):
            line = int(error.get("line", "1"))
            col = int(error.get("column", "1"))
            message = error.get("message", "").replace("\r", " ").replace("\n", " ")
            rule = error.get("source", "")
            severity = error.get("severity", "")
            findings.append((path, line, col, severity, rule, message))
    if result.returncode not in (0, 1) or (result.returncode == 1 and not findings):
        raise RuntimeError(f"textlint execution failed (exit {result.returncode})")
    findings.sort()
    # Avoid notifying users when diagnostics are identical; the body still stores
    # the last input hash so future unchanged runs can skip dependency installation.
    digest = os.environ["INPUT_HASH"]
    lines = [MARKER, f"<!-- input:{digest} -->", "", f"検出件数: {len(findings)}", ""]
    for path, line, col, severity, rule, message in findings:
        url = f"https://github.com/{repo}/blob/{branch}/{quote(path)}#L{line}"
        # Escape text to prevent Markdown/HTML injection and accidental mentions.
        def esc(s):
            return (s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                     .replace("@", "&#64;").replace("|", "&#124;").replace("`", "&#96;")
                     .replace("[", "&#91;").replace("]", "&#93;").replace("*", "&#42;"))
        lines.append(f"- [{esc(path)}:{line}:{col}]({url}) — {esc(message)} "
                     f"({esc(severity)}, {esc(rule)})")
    if not findings:
        lines.append("指摘事項はありません。")
    body = "\n".join(lines)
    if len(body.encode()) > 60000:
        body = body.encode()[:58000].decode("utf-8", errors="ignore") + "\n\n（表示上限により省略。詳細はActionsログを参照。）"
    print(result.stdout)
    old = issue()
    if old:
        number = str(old["number"])
        if old["body"].rstrip() != body.rstrip():
            subprocess.run(["gh", "issue", "edit", number, "--body-file", "-"],
                           input=body, text=True, check=True)
        if findings and old["state"] == "CLOSED":
            gh("issue", "reopen", number)
        elif not findings and old["state"] == "OPEN":
            gh("issue", "close", number)
    else:
        url = subprocess.check_output(["gh", "issue", "create", "--title", TITLE,
                                       "--body-file", "-"], input=body, text=True).strip()
        if not findings:
            gh("issue", "close", url)
    print(f"Checked {sha}: {len(findings)} findings")


def gh_sha():
    return subprocess.check_output(["git", "rev-parse", "HEAD"], text=True).strip()


if __name__ == "__main__":
    {"prepare": prepare, "report": report}[sys.argv[1]]()
