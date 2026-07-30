#!/bin/bash

# Create/attach tmux with session name '0' if interactive and not in vscode terminal
if [[ $- == *i* ]] && [[ -z "$TERM_PROGRAM" || "$TERM_PROGRAM" != "vscode" ]] && [[ -z "$TMUX" ]]; then
    if command -v tmux &> /dev/null; then
        # exec tmux new-session -A -s 0
    fi
fi
