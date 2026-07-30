#!/usr/bin/env sh

# Helper function to allow quick setting of aliases
# Syntax: _create_alias <command> <alias>
_create_alias() {
	if [ "$#" -ne 2 ]; then
		printf '%s\n' "Usage: _create_alias <command> <alias>" >&2
		return 1
	fi

	command_path="$1"
	alias_name="$2"

	if command -v "$command_path" >/dev/null 2>&1; then
		eval "alias $alias_name='$command_path'"
	# else
		# printf '%s\n' "Warning: command not found: $command_path" >&2
		# return 1
	fi
}

_create_alias opencode oc


mkcd() {
	mkdir -p -- "$1" && cd -- "$1"
}

alias df='df -h'
alias du='du -h'
alias cls='clear'
alias path='printf "%s
" "$PATH" | tr ":" "\n"'
