# Dotfiles

This repo is a collection of Neovim, tmux, zsh and VS Code configurations. This dotfile project is heavily inspired
by the dotfile projects of [Nick Nisi](https://github.com/nicknisi/dotfiles) and [Nick
Waywood](https://github.com/nwaywood/dotfiles). See Nick Nisi's talk [vim + tmux -
OMG!](https://www.youtube.com/watch?v=5r6yzFEXajQ) to be inspired.

## Install

1. `git clone https://github.com/airvin/dotfiles.git ~/.dotfiles`
1. `cd ~/.dotfiles`
1. `bash install.sh`

This `install.sh` script will start by installing all symbolic links into the home directory. Every file with a
`.symlink` extension will be symlinked to the home directory with a `.` in front of it. As an example, `zshrc.symlink`
will be symlinked as `~/.zshrc`. Then, all files in the `$DOTFILES/config` directory will be symlinked to the
`~/.config/` directory for applications that follow the [XDG based directory
specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html), such as Neovim.

Next, the script will check if the operating system is MacOS. If so, it will run `install/osx.sh` to change some OSX
configurations. Then it will install Homebrew (if not already installed) and will install all the packages listed in
`install/brew.sh`. Finally, `zsh` is configured and `oh-my-zsh` is installed.

There are other scripts in the `install` folder for installing packages which are not automated. To install
any of these packages, manually run the file (e.g. `bash install/vscode.sh`).

## Neovim Setup

[Neovim](https://neovim.io/) is a fork and drop-in replacement for vim. In most cases, the difference is not noticable
other than Neovim allows plugins to run asynchronously so that they do not freeze the editor. Vim and Neovim both use
Vimscript and most plugins will work in both. For this reason, they share the same configuration files in this setup.
Neovim uses the [XDG base directory
specification](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) which means it won't look for a
`.vimrc` in the home directory. Instead, its configuration looks like the following:

|                         | Vim        | Neovim                    |
|-------------------------|------------|---------------------------|
| Main configuration file | `~/.vimrc` | `~/.config/nvim/init.vim` |
| Configuration directory | `~/.vim`   | `~/.config/nvim`          |

Vim comes installed on most systems. Neovim will also be installed from Homebrew by default on Mac. For other systems,
Neovim may need to be installed manually. See the [Neovim website](https://neovim.io) for more information.

[`link.sh`](install/link.sh) will symlink the XDG configuration directory into the home directory. Inside of
[`.zshrc`](zsh/zshrc.symlink), the `EDITOR` shell variable is set to `nvim`, defaulting to Neovim for editor tasks, such
as git commit messages. Additionally, `vim` has been aliased to `nvim` in [`aliases.zsh`](zsh/aliases.zsh).

### Plugin Installation

Neovim plugins are managed with [vim-plug](https://github.com/junegunn/vim-plug). To install plugins, run:

`nvim +PlugInstall`

## ZSH Setup

ZSH is configured in the `zshrc.symlink` file, which will be symlinked to the home directory. The following occurs in
this file:

- set the EDITOR to nvim
- Recursively search the `$DOTFILES/zsh` directory for files ending in `.zsh` and source them
- Setup `oh-my-zsh` and install plugins
- Add the `~/bin` and `$DOTFILES/bin` directories to the path
- And more...

To change the theme of the terminal prompt, change the `ZSH_THEME` in `zsh/zshrc.symlink`. To use a custom theme, place
it in `~/.oh-my-zsh/custom/themes`. An example custom theme from [Nick Waywood](https://github.com/nwaywood/dotfiles) is
in `oh-my-zsh/custom/themes`.

## Tmux Setup

Tmux is a terminal multiplexor which allows multiple windows and splits in the terminal. It can be used to save multiple
project layouts in separate sessions. Tmux is configured in `~/.tmux.conf` (symlinked from `tmux/tmux.conf.symlink`),
and in `tmux/theme.sh`, which defines the colors used, the layout of the tmux bar, and what what will be displayed,
including the time and date, open windows, tmux session name, computer name. If not running on macOS, this configuration
should be removed.

### Plugin Installation

Tmux plugins are managed with [tpm](https://github.com/tmux-plugins/tpm). To install plugins, run:

`<prefix> - I`

from within tmux. This installs the `tmux-resurrect` plugin which lets tmux sessions/windows/panes be persisted across
OS reboots. `prefix - ^s` to save the tmux environment and `prefix - ^r` to restore the tmux environent.

