---
description: Rescan ~/.claude and refresh the hardcoded list inside /toolbox.
---

Refresh the hardcoded listing inside `~/.claude/commands/toolbox.md` so it matches the current state of disk.

## Steps

1. List every `*.md` file in `~/.claude/commands/`. The command name is the filename minus `.md`.

2. List every `SKILL.md` under `~/.claude/skills/**/`. Take `name` from frontmatter and the parent category from the directory path (e.g. `engineering`, `productivity`).

3. For each file, extract the frontmatter `description` field. Trim to the first sentence (stop at the first `.` followed by space or end of string). If a description spans multiple sentences with extra detail, keep only the first.

4. Build the new listing block in this exact format, sorted alphabetically within each section:

   ```
   **Commands**
   - `/<name>` — <description>
   ...

   **Skills**
   - `/<name>` (<category>) — <description>
   ...
   ```

   Show skill names with a leading `/` so they render with the same highlighting as commands, even though skills aren't slash-invocable.

5. Edit `~/.claude/commands/toolbox.md`. Replace everything **after** the line `Output exactly the following text verbatim, with no preamble, commentary, or trailing summary:` (and the blank line that follows) with the freshly-built listing. Preserve the frontmatter and the instruction line above it.

6. Print a single line confirmation: `Updated toolbox.md — <N> commands, <M> skills.`
