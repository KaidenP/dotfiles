# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with [Chezmoi](https://www.chezmoi.io/). It contains configuration for shells (bash/zsh), terminal multiplexers (tmux), prompt theming (oh-my-posh), and various CLI tool configurations.

## Common Commands

### Viewing Changes
```bash
# View pending changes before applying
chezmoi diff

# View diff for a specific file
chezmoi diff ~/.zshrc
```

### Managing Files
```bash
# Add a home directory file to chezmoi management
chezmoi add ~/.config/myapp/config.yaml

# Edit a managed file in place
chezmoi edit ~/.zshrc

# Apply all changes to home directory
chezmoi apply

# Apply with verbose output
chezmoi apply --verbose
```

### Testing
```bash
# Test what would be changed without applying
chezmoi status

# Show detailed file contents
chezmoi cat ~/.zshrc
```

## Architecture & Key Files

### Repository Structure

**Dotfiles** (files starting with `dot_` are installed to `~`):
- `dot_zshrc` / `dot_bashrc` - Shell configuration
- `dot_tmux.conf` - Tmux terminal multiplexer config
- `dot_ohmyposh.yaml` - Oh-my-posh prompt theme
- `dot_gitconfig` - Git configuration
- `dot_profile` / `dot_zprofile` - Login shell initialization

**Configuration Directories**:
- `dot_config/` - Application configs (maps to `~/.config/`)
  - `profile.d/` - Shell initialization scripts sourced on login (executable scripts)
  - `atuin/` - Command history tool config
  - `ghostty/` - Terminal emulator config
  - `input-remapper-2/` - Key remapping config
  - `systemd/` - User systemd services

**Setup & Installation**:
- `.chezmoiscripts/` - Scripts executed at various stages
  - `run_after_install-*.sh` - Run after initial apply
  - `run_onchange_*.sh` - Run when files change
- `.chezmoiexternal.yaml` - External git repos (oh-my-zsh, tmux plugins, etc.)
- `.chezmoi.yaml.tmpl` - Age encryption + hooks configuration
- `.hooks/` - Platform-specific hooks (Linux/Windows)

### Key Installation Flows

**On `chezmoi apply`:**
1. Pre-hooks run (decrypt private key)
2. Dotfiles are linked/copied to home directory
3. External repos are synced (oh-my-zsh, tmux plugins, etc.)
4. `run_onchange_*.sh` scripts execute if tracked files changed
5. `run_after_install_*.sh` scripts execute (Atuin login, Node setup, Python setup)

**Profile Scripts** (`~/.config/profile.d/executable_*.sh`):
- Sourced by zshrc/bashrc during login
- Set up PATH for development tools (Rust/Cargo, Bun, Node/nvm, Python venv)
- Configure tool integration (ssh-agent, Atuin sync, Autoenv, Ghostty)
- Single-responsibility: one script per tool/subsystem

### Platform Support

The repository supports both Linux and Windows:
- `.chezmoi.yaml.tmpl` templates some configs based on OS
- `.hooks/nix/` - Linux hooks
- `.hooks/win/` - Windows PowerShell hooks
- Some scripts detect OS with `uname -s`

### Sensitive Data

The repository uses **age encryption** for secrets:
- Private key at `~/.age_identity` (decrypted on apply via hook)
- Encrypted files in `dot_local/share/private_atuin/` (e.g., Atuin login credentials)
- During edit/apply, encrypted data is automatically decrypted using templates

## Workflow Tips

- **Edit dotfiles in place**: Use `chezmoi edit ~/.zshrc` to edit in source directory
- **Add new managed files**: `chezmoi add ~/.myfile` brings them under management
- **Test before applying**: Always run `chezmoi diff` first
- **Profile scripts are sourced each login**: Update them if you're changing PATH or tool initialization
- **External repos auto-update**: Defined in `.chezmoiexternal.yaml` (oh-my-zsh, tpm, etc.)
- **Script responsibilities**: Keep profile.d scripts small, one per tool/feature
