#!/bin/sh

# Ghostty shell integration
# Detect shell and source the appropriate integration file

if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    case "$(basename "${SHELL}")" in
        bash)
            builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
            ;;
        zsh)
            source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
            ;;
        fish)
            source "$GHOSTTY_RESOURCES_DIR"/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
            ;;
        elvish)
            use "$GHOSTTY_RESOURCES_DIR"/shell-integration/elvish/lib/ghostty-integration
            ;;
        nushell)
            source $GHOSTTY_RESOURCES_DIR/shell-integration/nushell/vendor/autoload/ghostty.nu
            ;;
    esac
fi
