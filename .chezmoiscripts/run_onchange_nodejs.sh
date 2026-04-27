#!/bin/bash

# Can't use for nvm
# set -euo pipefail

# Global npm packages to install
NPM_PACKAGES=(
  npm@latest
  yarn
  pnpm
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
