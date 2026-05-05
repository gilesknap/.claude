#!/usr/bin/env bash
# Claude Code status line: model + context usage
# Uses python3 instead of jq for JSON parsing (jq not always available)

input=$(cat)

export _SL_INPUT="$input"
eval "$(python3 -c '
import json, os
d = json.loads(os.environ["_SL_INPUT"])
model = d.get("model", {}).get("display_name", "unknown model")
cwd = d.get("workspace", {}).get("current_dir", "") or d.get("cwd", "")
ctx = d.get("context_window", {})
used = ctx.get("used_percentage")
remaining = ctx.get("remaining_percentage")
cost = d.get("cost", {}).get("total_cost_usd", 0) or 0
print(f"model={model!r}")
print(f"cwd={cwd!r}")
print(f"cost_info=\"cost: \${cost:.2f}\"")
if used is not None and remaining is not None:
    print(f"context_info=\"ctx: {int(round(used))}% used / {int(round(remaining))}% left\"")
else:
    print("context_info=\"ctx: new session\"")
' 2>/dev/null)" || {
  printf "statusline error"
  exit 0
}

# Shorten cwd: replace $HOME with ~
home_dir="$HOME"
short_cwd="${cwd/#$home_dir/~}"

username=$(whoami 2>/dev/null || echo "unknown")

printf "\033[0;35m%s\033[0m  \033[0;36m%s\033[0m  \033[0;33m%s\033[0m  \033[0;32m%s\033[0m  \033[0;31m%s\033[0m" \
  "$username" "$model" "$short_cwd" "$context_info" "$cost_info"
