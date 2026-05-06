# GitHub interactions

- Never use SSH keys for any git or GitHub operation. Always go via HTTPS + gh's credential helper.
- Use `gh` for everything that has a `gh` subcommand (PR edits, issue ops, API calls, etc.).
- For raw `git` operations against GitHub (push, fetch, clone), use gh's credential helper — never extract the PAT into a URL or env var:
  ```
  GIT_CONFIG_GLOBAL=/dev/null git -c credential.helper='!gh auth git-credential' \
    push https://github.com/<owner>/<repo>.git <branch>
  ```
- `GIT_CONFIG_GLOBAL=/dev/null` is required: my global git config rewrites `https://github.com/` → `ssh://git@github.com/` via `insteadOf`.
