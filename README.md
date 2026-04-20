# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Setup

### Initial Setup

1. Install chezmoi:
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply KaidenP
   ```

2. Or clone and apply manually:
   ```bash
   chezmoi init --apply https://github.com/KaidenP/dotfiles.git
   ```

### Daily Usage

Apply local changes to your home directory:
```bash
chezmoi apply
```

Edit dotfiles in the chezmoi source directory:
```bash
chezmoi edit ~/.config/example
```

View pending changes:
```bash
chezmoi diff
```

Re-apply after manual edits:
```bash
chezmoi apply
```

## Structure

- `dot_config/` - Application configs (e.g., zsh, nvim, git)
- `dot_local/` - Local files in `~/.local`
- `exact_*` - Exact directory contents (deleted files not in repo are removed)
- `.chezmoidata.yaml` - Template variables and system-specific config

## Adding Files

Move files into chezmoi management:
```bash
chezmoi add ~/.zshrc
chezmoi add ~/.config/example
```

## Resources

- [chezmoi Documentation](https://www.chezmoi.io/user-guide/)
- [Quick Start](https://www.chezmoi.io/quick-start/)
