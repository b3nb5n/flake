[ -x "$(command -v direnv)" ] || return

eval "$(direnv hook zsh)"
