#!bin/sh

echo "Installing homebrew packages..."

# brew stuff
brew tap caskroom/cask

# core development tools
brew install git
brew install tmux
brew install zsh
brew install coreutils
brew install watch
brew install autoconf
brew install automake
brew install libtool

# docker/kubernetes
brew install docker
brew install docker-compose
brew install minikube
brew install virtualbox

# languages and langauge tools
brew install dep
brew install haskell-stack
brew cask install elm-platform
brew install python3
brew install rustup
echo "-------------------------------------------------"
echo "Make sure to run rustup-init to install the Rust compiler and tools"
echo "-------------------------------------------------"
brew install openjdk@8
# symlink to folder where the java wrapper expects to find it
sudo ln -sfn /usr/local/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk


# CLI tools
brew install z
brew install fzf
brew install tree
brew install jq
brew install gettext
brew install fd # good find
brew install exa # good ls
brew install bat # good cat
brew install the_silver_searcher # good grep
brew install ripgrep # good grep
brew install --HEAD https://raw.githubusercontent.com/junegunn/blsd/master/blsd.rb

# neovim 
brew install neovim/neovim/neovim

# show key presses for demos/talks
# brew cask install keycastr
