# ~/.claude

My personal [Claude Code](https://claude.com/claude-code) config — slash commands, skills, hooks, settings, and the status-line script.

Published via a deny-by-default `.gitignore`: only authored content is tracked. Runtime state (transcripts, history, caches, credentials) stays local.

## Layout

| Path | What |
|---|---|
| `commands/` | Slash commands — short, user-invoked prompts. |
| `skills/` | Skills — instructions plus bundled assets, auto-loaded by description match. |
| `agents/` | Subagent definitions (currently empty). |
| `hooks/` | Hook scripts wired up via `settings.json` (currently empty). |
| `settings.json` | Permissions, model choice, hooks, status line, enabled plugins. Sanitised — no project paths. |
| `keybindings.json` | Key remaps. |
| `statusline-command.sh` | Status-line script referenced by `settings.json`. |
| `package.json` | npm metadata for any scripts that need it. |

For a one-line summary of every command and skill, run `/toolbox` from inside Claude Code.

## Use

Clone into `~/.claude/`, or selectively copy individual commands/skills into your own. Most things assume Claude Code ≥ the version that introduced skills; see [Anthropic's docs](https://docs.claude.com/en/docs/claude-code/overview) if anything looks unfamiliar. Or even better,
here is [an interactive summary of the .claude folder](https://code.claude.com/docs/en/claude-directory#explore-the-directory)

`settings.json` will likely need adjustment for your environment — at minimum the `permissions.allow` list and any plugin choices.

## Credits

Several engineering skills (`tdd`, `diagnose`, `triage`, `to-prd`, `to-issues`, `improve-codebase-architecture`, `grill-with-docs`, `setup-matt-pocock-skills`) are derived from [Matt Pocock's published skills](https://github.com/mattpocock).
