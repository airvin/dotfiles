# misc aliases

# docker
alias dc='docker-compose'
alias lzd='lazydocker'

# neovim
alias vim='nvim'

# misc
alias cat='bat'
alias ls="eza"
alias la="eza -a"
alias ll="eza -la"

mkcd () {
    test -d "$1" || mkdir "$1" && cd "$1"
}
