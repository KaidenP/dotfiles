#!/bin/bash

# Can't use for nvm
# set -euo pipefail

# Global npm packages to install
NPM_PACKAGES=(
  npm@latest
  yarn
  pnpm
  bun
)

# Install or update nvm
echo "Installing/updating nvm..."
if [ -d "$HOME/.nvm" ]; then
  echo "nvm already exists, updating..."
  cd "$HOME/.nvm" && git fetch --quiet origin && git checkout --quiet $(git describe --abbrev=0 --tags)
else
  echo "Installing nvm..."
  git clone --quiet https://github.com/nvm-sh/nvm.git "$HOME/.nvm"
  cd "$HOME/.nvm" && git checkout --quiet $(git describe --abbrev=0 --tags)
fi

# Source nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install latest Node.js LTS
echo "Installing latest Node.js LTS..."
nvm install --lts
nvm use --lts
nvm alias default node

# Install global npm packages
echo "Installing global npm packages..."
npm install --global "${NPM_PACKAGES[@]}"

echo "Node.js setup complete!"
node --version
npm --version

# Install opencode-ai via bun
echo "Installing opencode-ai via bun..."
if ! command -v bun &> /dev/null; then
  echo "bun not found, installing..."
  npm install --global bun
fi
bun add --global opencode-ai

# Setup opencode systemd user service
echo "Setting up opencode systemd user service..."
mkdir -p "$HOME/.config/systemd/user"

OPENCODE_SERVICE="$HOME/.config/systemd/user/opencode.service"
cat > "$OPENCODE_SERVICE" << 'EOF'
[Unit]
Description=Opencode Web Server
After=network.target

[Service]
Type=simple
ExecStart=%h/.bun/bin/opencode serve --port 8888 --hostname 0.0.0.0
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF

# Reload systemd user daemon and enable/start the service
systemctl --user daemon-reload
systemctl --user enable opencode.service
systemctl --user start opencode.service

# echo "Opencode service installed and started on port 8888"
# systemctl --user status opencode.service
