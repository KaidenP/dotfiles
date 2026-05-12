# Atuin sync integration
if [[ -n "$ZSH_VERSION" ]] && command -v atuin &> /dev/null && [[ -o interactive ]]; then
    _atuin_sync() {
        if ! atuin sync > /dev/null 2>&1; then
            echo "Warning: atuin sync failed" >&2
        fi
    }

    # Set up preexec hook to sync before ssh or sudo -i
    _atuin_sync_preexec() {
        if [[ "$3" =~ ^ssh ]] || [[ "$3" =~ ^sudo\ -i ]]; then
            _atuin_sync &!
        fi
    }

    preexec_functions+=( _atuin_sync_preexec )
    _atuin_sync &!
fi

eval "$(atuin init "${SHELL##*/}")"
command -v compdef &> /dev/null && eval "$(atuin gen-completions --shell "${SHELL##*/}")"