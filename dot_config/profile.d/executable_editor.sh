#!/usr/bin/env sh

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
	export EDITOR='code -wr'
else
	export EDITOR='nano'
fi