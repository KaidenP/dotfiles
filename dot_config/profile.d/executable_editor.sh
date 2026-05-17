#!/usr/bin/env sh
if [[ "$EDITOR" != code* ]]; then
	if [[ "$VSCODE_INJECTION" == "1" ]]; then
		export EDITOR='code -wr'
	else
		export EDITOR='nano'
	fi
fi