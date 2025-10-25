source "$ZSH_PLUGIN_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh"

bindkey '^[[A' history-substring-search-up
bindkey '^K' history-substring-search-up
bindkey -M vicmd 'k' history-substring-search-up

bindkey '^[[B' history-substring-search-down
bindkey '^J' history-substring-search-down
bindkey -M vicmd 'j' history-substring-search-down
