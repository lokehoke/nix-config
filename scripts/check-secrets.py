#!/usr/bin/env python3
"""Check tracked text files for common accidentally copied credentials."""
import pathlib
import re
import subprocess
import sys

root = pathlib.Path(__file__).resolve().parent.parent
paths = subprocess.check_output(
    ["git", "ls-files", "-z"], cwd=root
).decode().split("\0")
patterns = [
    re.compile(r"-----BEGIN (?:OPENSSH |RSA |EC |DSA )?PRIVATE KEY-----"),
    re.compile(r"\b(?:gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{30,})\b"),
    re.compile(r"\bAKIA[A-Z0-9]{16}\b"),
    re.compile(r"\bAQAD[-A-Za-z0-9_]{20,}\b"),
    re.compile(r"(?i)(?:api[_-]?key|access[_-]?token|password|secret)\s*[=:]\s*[\"'][A-Za-z0-9_./+=-]{16,}"),
]
bad = []
for name in filter(None, paths):
    path = root / name
    if not path.is_file() or path.is_symlink():
        continue
    try:
        content = path.read_text()
    except UnicodeDecodeError:
        bad.append((name, "binary file needs manual review"))
        continue
    for number, line in enumerate(content.splitlines(), 1):
        if any(pattern.search(line) for pattern in patterns):
            bad.append((name, number))
for name, location in bad:
    print(f"Review {name}:{location}; value hidden", file=sys.stderr)
if bad:
    sys.exit(1)
print(f"Credential pattern check passed for {len(list(filter(None, paths)))} tracked paths.")
