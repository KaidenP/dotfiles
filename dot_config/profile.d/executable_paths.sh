#!/usr/bin/env sh

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# snap puts bins in /snap/bin
if [ -d "/snap/bin" ]; then
	PATH="$PATH:/snap/bin"
fi

# Bun
if [ -d "$HOME/.bun/bin" ]; then
	PATH="$HOME/.bun/bin:$PATH"
fi