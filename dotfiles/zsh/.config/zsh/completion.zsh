zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' verbose true
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion::complete:*' use-cache true
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME}/zsh/completions"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:manuals' separate-sections true

local DUMP_PATH="$ZSH_STATE_DIR/.zcompdump"

zmodload zsh/complist
autoload -Uz compinit && compinit -d "$DUMP_PATH"
autoload -Uz bashcompinit && bashcompinit -d "$DUMP_PATH"
