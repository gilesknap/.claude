---
name: pr-slice-tables
description: Format or update a multi-slice PR's body so each issue (slice) gets its own commit table. Use when a branch carries commits from multiple `Fixes #N` / `Part of #N` issues onto a single PR, when the user asks to format/update the PR description with a per-slice table, or after a new slice lands on an existing multi-slice PR.
---

# PR slice tables

When a single PR carries commits from multiple sliced issues (typically the output of `/to-issues`-style PRD breakdowns), structure its body as one table per slice rather than a flat summary. Reviewers can then scope a pass slice-by-slice and commit-by-commit.

## Body shape

1. Open with one `Fixes #N` line per slice, separate lines, in slice-merge order.
2. One short paragraph framing the PR (which slice is the foundation, which layers on which).
3. One section per slice:

   ```
   ## Fixes #N — <slice title>

   | # | Commit | Headline |
   |---|---|---|
   | K | [`<short-sha>`](https://github.com/<org>/<repo>/pull/<PR>/commits/<full-sha>) | <commit headline> |
   ```

   - `K` numbers commits **sequentially across the whole PR** — the second slice's table picks up where the first ended.
   - Order commits within a slice in their on-branch (topological) order, oldest first.
4. Close with a `## How to review` section that recommends commit-by-commit (each commit is green in isolation) and the test command(s).

## Workflows

### Initial format (first time the PR has more than one slice)

1. Fetch PR + repo metadata: `gh pr view <N> --json headRefName,baseRefName` and `gh repo view --json nameWithOwner -q .nameWithOwner`.
2. Walk branch commits oldest-first: `git log <base>..<head> --reverse --format='%H%x09%s%x09%b%x1e'` (record separator on body).
3. For each commit, scan the message body for `Fixes #<N>` / `Part of #<N>` / `Closes #<N>` to find its slice. If a commit has none, **stop and ask the user** — don't guess.
4. Group commits by slice in slice-merge order (the order each slice's last commit appears on the branch).
5. Render the body per the shape above and push it.

### Append a new slice (the recurring case)

1. Read the current body. Note the highest commit number `K` used in the last table.
2. Get the commits new since that table's last SHA.
3. Render one new `## Fixes #N — …` section, numbering from `K+1`.
4. Add the new `Fixes #N` line at the top, preserving the existing ones.
5. **Do not rewrite frozen tables** — landed slice tables are part of the review trail; append only.
6. Push the body.

## Pushing the body

`gh pr edit --body` aborts on repos that still expose the deprecated project-cards GraphQL field. Use the REST API instead:

```
jq -Rs '{body: .}' /tmp/body.md > /tmp/payload.json
gh api -X PATCH /repos/<org>/<repo>/pulls/<N> --input /tmp/payload.json -q .html_url
```

Verify with `gh pr view <N> --json body -q .body | head -30`.

## Anti-patterns

- Rewriting an already-frozen slice table — numbering and SHAs in landed tables are part of the review trail.
- One unified table for all commits — loses the slice → commits grouping reviewers want.
- Numbering restarts per slice — reviewers lose the cross-slice "commit 9" anchor.
- Silently dropping or guessing slice membership for commits with no `Fixes/Part of` line — stop and ask.

## Reference example

PR #360 in DiamondLightSource/fastcs (slices #353 + #354) is the canonical body. Fetch it with `gh pr view 360 --repo DiamondLightSource/fastcs --json body -q .body` if you need a model to copy.
