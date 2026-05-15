#!/usr/bin/env bash
#
# Stop hook: notify when Claude Code session ends

set -uo pipefail

input=$(cat)
stop_hook_active=$(jq -r '.stop_hook_active // false' <<<"$input")
last_message=$(jq -r '.last_assistant_message // ""' <<<"$input")

if [[ "$stop_hook_active" == "true" ]]; then
    title="Claude Code"
    body="Continuing from stop hook..."
else
    title="Claude Code"
    # Show first 100 chars of last message, or generic message
    if [[ -n "$last_message" ]]; then
        body="${last_message:0:100}"
        [[ ${#last_message} -gt 100 ]] && body="${body}..."
    else
        body="Session completed"
    fi
fi

notify-send -i "$HOME/.claude/claude-logo.svg" -a Claude "$title" "$body" 2>/dev/null || exit 0
