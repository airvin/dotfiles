#!bin/sh

echo "Installing homebrew packages..."

# brew stuff
brew tap caskroom/cask

# core development tools
brew install git
brew install tmux
brew install zsh

# languages and langauge tools
brew install dep
brew install haskell-stack
brew cask install elm-platform
brew install python3
brew install openjdk@8

# CLI tools
brew install z
brew install fzf
brew install tree
brew install jq
brew install fd # good find
brew install exa # good ls
brew install bat # good cat
brew install the_silver_searcher # good grep
brew install ripgrep # good grep
brew install --HEAD https://raw.githubusercontent.com/junegunn/blsd/master/blsd.rb

# neovim 
brew install neovim/neovim/neovim

# for vim tagbar
brew install ctags-exuberant
brew install gotags

# show key presses for demos/talks
# brew cask install keycastr
