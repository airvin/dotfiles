# misc aliases

# docker
alias dc='docker-compose'
alias lzd='lazydocker'

# neovim
alias vim='nvim'

# misc
alias cat='bat'
alias ls="exa"
alias la="exa -a"
alias ll="exa -la"

mkcd () {
    test -d "$1" || mkdir "$1" && cd "$1"
}
