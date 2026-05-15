#!/usr/bin/env bash
#
# PermissionRequest hook: send a desktop notification.
# The TUI prompt provides the actual approval/denial interface.

set -uo pipefail

input=$(cat)
tool=$(jq -r '.tool_name // "unknown"' <<<"$input")

case "$tool" in
    Bash)
        detail=$(jq -r '.tool_input.command // ""' <<<"$input")
        ;;
    Read|Edit|Write)
        detail=$(jq -r '.tool_input.file_path // ""' <<<"$input")
        ;;
    *)
        detail=""
        ;;
esac

body="$tool"
[[ -n "$detail" ]] && body="$tool: ${detail:0:200}"

notify-send -i "$HOME/.claude/claude-logo.svg" -a Claude 'Claude needs permission' "$body" 2>/dev/null || exit 0

exit 0
