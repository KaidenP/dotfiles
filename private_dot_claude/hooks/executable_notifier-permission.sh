#!/usr/bin/env bash
#
# PermissionRequest hook: pop a desktop notification with Approve/Deny
# buttons. On click, emit the corresponding hookSpecificOutput JSON. On
# timeout or dismissal, emit nothing so the in-TUI prompt takes over.

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

choice=$("$HOME/.local/bin/notifier" \
    -i "$HOME/.claude/claude-logo.svg" \
    -u critical \
    -t 5000 \
    -A approve=Approve \
    -A deny=Deny \
    --wait \
    'Claude needs permission' "$body" 2>/dev/null) || exit 0

case "$choice" in
    approve) behavior=allow ;;
    deny)    behavior=deny  ;;
    *)       exit 0 ;;
esac

jq -nc --arg b "$behavior" '{
  hookSpecificOutput: {
    hookEventName: "PermissionRequest",
    decision: { behavior: $b }
  }
}'
