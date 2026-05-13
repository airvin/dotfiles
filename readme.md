# Dotfiles - Minimal Setup

A minimal dotfiles collection optimised for development with IntelliJ IDEA and VS Code, with Neovim available for quick terminal editing.

## Quick Start

```bash
git clone https://github.com/airvin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install.sh
```

The install script will:
1. Create symlinks for configuration files
2. Apply macOS system settings (keyboard speed, dock auto-hide)
3. Install packages via Homebrew

## What's Included

### Shell (ZSH)
- **oh-my-zsh** with essential plugins: git, vi-mode, history-substring-search
- Vi keybindings with `jk` to escape insert mode
- FZF for fuzzy file/history search
- Minimal PATH configuration for Node.js and Java development

### Editor: Neovim
- **Purpose**: Quick terminal-based file editing (not the primary editor)
- **Color theme**: OneDark
- **Essential plugins**: FZF (fuzzy search), Fugitive (git), tmux integration
- **Space leader key** with intuitive bindings for common tasks

### Terminal Multiplexer: Tmux
- Pre-configured with sensible keybindings
- Vim-tmux navigation integration (Ctrl+hjkl)
- Plugin persistence (tmux-resurrect, tmux-continuum)
- Includes `bin/tm` helper to pick an existing tmux session or create a new one

Use the tmux helper:
1. Run `tm`
2. Pick a session from the menu or choose "New Session"
3. The script will attach/create and replace the current shell process

Install tmux plugins:
1. Start tmux (`tm` or `tmux new`)
2. Press `Ctrl+B` then `I` (capital i) to install plugins via tpm
3. Plugins (tmux-yank, tmux-resurrect, tmux-continuum) will download automatically

### VS Code
- Minimal settings focused on core development
- Optional Vim extension support
- Prettier for code formatting
- Basic keybindings for split/terminal management

### Git Configuration
**Note**: Git config is not auto-symlinked. If you have an existing `~/.gitconfig`, you can manually add useful config from `gitconfig.example`.

The dotfiles also symlink [git/gitignore_global.symlink](git/gitignore_global.symlink) as `~/.gitignore_global` for global gitignore rules.

### Package Management
- **CLI Tools**: fzf, ripgrep, fd, bat, eza, jq

## Important Notes

### Language Support
This setup is optimised for **JavaScript/Node.js** and **Java** development. Other language runtimes (Python, Ruby, Go, Rust, Haskell) have been removed. To add support for other languages:
- Update `install/Brewfile` with needed runtimes
- Add appropriate PATH configurations to `zsh/zshrc.symlink`

### macOS Settings
The `install/osx.sh` script applies these settings:
- Keyboard repeat rate and initial delay (fast typing experience)
- Dock auto-hide with 0.5s delay
- Disable workspace animation

To modify these, edit `install/osx.sh` before running install.sh.

### Neovim Plugins
To install Neovim plugins after setup:
```bash
nvim +PlugInstall
```

Current plugins include:
- Color scheme (OneDark)
- Fuzzy finder (FZF)
- Git integration (Fugitive)
- Text manipulation (surround, commentary, unimpaired)
- Tmux navigation

### Custom Scripts
Scripts in `bin/` directory are added to PATH:
- `tm` - Smart tmux session manager (pick existing or create new)

## Typical Workflow

1. **Development**: IntelliJ IDEA or VS Code
2. **Terminal**: Tmux with ZSH for command line work
3. **Quick edits**: Neovim in terminal (`:` key in tmux to edit files)
4. **File navigation**: FZF (`Ctrl+T` in shell or `<leader>f` in Neovim)
5. **Git operations**: Git aliases or integrations in IDE

## File Structure

```
.dotfiles/
├── install.sh              # Main installation script
├── install/
│   ├── link.sh            # Create symlinks
│   ├── osx.sh             # macOS system settings
│   └── Brewfile           # Homebrew packages
│   └── vscode.sh          # VS Code extensions
├── zsh/
│   ├── zshrc.symlink      # Main shell configuration
│   └── aliases.zsh        # Command aliases
├── nvim/
│   └── init.vim           # Neovim configuration
├── tmux/tmux.conf.symlink # Tmux configuration
├── git/gitconfig.example  # Git aliases (manual setup)
└── vscode/                # VS Code settings
```

## Customisation

Edit configuration files directly:
- **Shell aliases**: [zsh/aliases.zsh](zsh/aliases.zsh)
- **Neovim settings**: [config/nvim/init.vim](config/nvim/init.vim)
- **Git aliases**: Manually add from [git/gitconfig.example](git/gitconfig.example) to your `~/.gitconfig`
- **VSCode settings**: [vscode/settings.json](vscode/settings.json)
- **Packages**: [install/Brewfile](install/Brewfile)

After modifications, reload configurations:
```bash
# Shell
source ~/.zshrc

# Neovim (inside Neovim)
:source ~/.config/nvim/init.vim

# Git
git config --list
```

## Keyboard Shortcuts (Neovim)

| Binding | Action |
|---------|--------|
| `jk` | Exit insert mode |
| `<Space>f` | Find files |
| `<Space>b` | List buffers |
| `<Space>a` | Grep project |
| `gd` | Go to definition |
| `gr` | Find references |
| `<Space>gs` | Git status |
| `<Space>w` | Save file |
| `K` | Show documentation |

