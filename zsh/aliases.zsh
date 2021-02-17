# misc aliases

# docker
alias dc='docker-compose'
alias d='docker'

# neovim
alias vim='nvim'

# git
alias g='git'

# misc
alias c='clear'
alias cat='bat'
alias ccat='pygmentize -g'
alias wiki='nvim +VimwikiIndex'
alias vimf='nvim "+Denite file_rec"'
alias vimn='nvim +NERDTreeToggle'
alias find='find . -name'
alias ls="exa"
alias la="exa -a"
alias ll="exa -la"

mkcd () {
    test -d "$1" || mkdir "$1" && cd "$1"
}
