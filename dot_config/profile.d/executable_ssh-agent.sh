#!/usr/bin/env sh

# Set SSH_AUTH_SOCK if ssh-agent-pipe.service is active (installed by shell-wsl feature)
if command -v systemctl >/dev/null 2>&1 && systemctl --user is-active --quiet ssh-agent-pipe.service 2>/dev/null; then
	export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.sock"
fi