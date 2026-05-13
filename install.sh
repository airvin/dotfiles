#!/bin/bash

set -euo pipefail

DOTFILES="${HOME}/.dotfiles"

echo "Symlinking dotfiles"
source install/link.sh

if [ "$(uname)" == "Darwin" ]; then
	echo -e "\n\nRunning on OSX"

  echo "Setting up osx settings"
  source install/osx.sh

  echo "Brewing all the things (using Brewfile)"
  if command -v brew >/dev/null 2>&1; then
      brew bundle --file="$DOTFILES/install/Brewfile"
  else
      echo "Homebrew not found — skipping Brewfile step. Install Homebrew from https://brew.sh/ and re-run."
  fi
fi

echo "Installing tpm (tmux package manager)"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || { echo "Failed to clone tpm"; exit 1; }
else
    echo "tpm already installed"
fi


# zsh setup
if ! command -v zsh >/dev/null 2>&1; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    zsh_path="$(command -v zsh)"
    if [ -z "$zsh_path" ]; then
        echo "Unable to determine zsh path"
        exit 1
    fi
    chsh -s "$zsh_path"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "oh-my-zsh already installed"
fi

echo "Installing VS Code extensions"
if command -v code >/dev/null 2>&1; then
    source install/vscode.sh
else
    echo "VS Code CLI not found - skipping extensions. Open VS Code and install the 'code' shell command, then re-run install.sh."
fi

echo "----------"
echo "Go to keyboard settings and map caps lock to ctrl"
echo "----------"
echo ""
