#!/bin/bash
set -e

# Exit early silently if prerequisites are not met
if ! command -v npiperelay.exe &>/dev/null; then
  exit 0
fi

if [[ ! -e /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
  exit 0
fi

if [[ $(id -u) -eq 0 ]]; then
  exit 0
fi

# Create wrapper script for npiperelay.exe
mkdir -p "$HOME/.local/share/wsl-ssh-agent"
cat > "$HOME/.local/share/wsl-ssh-agent/npiperelay-win.sh" <<EOF
#!/bin/bash
exec "$(command -v npiperelay.exe)" "\$@"
EOF
chmod +x "$HOME/.local/share/wsl-ssh-agent/npiperelay-win.sh"

if ! command -v systemctl &>/dev/null; then
  echo "systemctl not found — is systemd running in this WSL instance?"
  echo "Service written but not enabled. To enable manually:"
  echo "  systemctl --user daemon-reload"
  echo "  systemctl --user enable --now ssh-agent-pipe"
  exit 0
fi

systemctl --user daemon-reload
systemctl --user enable --now ssh-agent-pipe

echo "ssh-agent-pipe service enabled and started."
echo "SSH_AUTH_SOCK will be set to \$XDG_RUNTIME_DIR/ssh-agent.sock on next login, if 'shell' feature also installed"
echo "For the current session: export SSH_AUTH_SOCK=\$XDG_RUNTIME_DIR/ssh-agent.sock"