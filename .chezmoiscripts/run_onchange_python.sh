#!/bin/bash

set -euo pipefail

# pip packages to install
PIP_PACKAGES=(
  pip
  ansible
  ansible-lint
)

VENV_DIR="$HOME/.venv"

# Create or update virtual environment
echo "Setting up Python virtual environment..."
if [ -d "$VENV_DIR" ]; then
  echo "Virtual environment exists, updating..."
  python3 -m venv "$VENV_DIR" --upgrade
else
  echo "Creating virtual environment..."
  python3 -m venv "$VENV_DIR"
fi

# Activate virtual environment
source "$VENV_DIR/bin/activate"

# Install/upgrade pip packages
echo "Installing pip packages..."
pip install --upgrade --upgrade-strategy only-if-needed "${PIP_PACKAGES[@]}"

echo "Python setup complete!"
python --version
pip --version
