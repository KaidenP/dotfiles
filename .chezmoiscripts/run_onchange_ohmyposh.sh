#!/bin/bash

set -euo pipefail

INSTALL_DIR="$HOME/.local/bin"

mkdir -p "$INSTALL_DIR"

# Install or update oh-my-posh
echo "Installing/updating oh-my-posh..."
if command -v oh-my-posh >/dev/null 2>&1; then
  echo "oh-my-posh is already installed, updating to the latest version..."
else
  echo "oh-my-posh is not installed, installing now..."
fi

curl -fsSL https://ohmyposh.dev/install.sh | bash -s -- -d "$INSTALL_DIR"
export PATH="$INSTALL_DIR:$PATH"

echo "oh-my-posh setup complete!"
oh-my-posh --version
