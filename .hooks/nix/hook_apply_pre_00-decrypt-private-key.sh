#!/usr/bin/env bash

if [ ! -f "${HOME}/.age_identity" ]; then
    chezmoi age decrypt --output "${HOME}/.age_identity" --passphrase "$CHEZMOI_SOURCE_DIR/.age_identity.age"
    chmod 600 "${HOME}/.age_identity"
fi