setopt AUTO_PARAM_SLASH # complete folders with / at end
setopt LIST_TYPES       # mark type of completion suggestions
setopt HASH_LIST_ALL    # whenever a command completion is attempted, make sure the entire command path is hashed first
setopt COMPLETE_IN_WORD # allow completion from within a word/phrase
setopt ALWAYS_TO_END    # move cursor to the end of a completed word

zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' verbose true
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion::complete:*' use-cache true
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME}/zsh/completions"
zstyle ':completion:*:descriptions' format [%d]
zstyle ':completion:*:manuals' separate-sections true

# Enable cached completions, if present
if [[ -d "${XDG_CACHE_HOME}/zsh/fpath" ]]; then
    fpath=("${XDG_CACHE_HOME}/zsh/fpath" ${fpath})
fi

# Additional completions
fpath=("${ZSH_PLUGIN_DIR}/zsh-completions/src" ${fpath})

zmodload zsh/complist
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

# Automatic completions
source "${ZSH_PLUGIN_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Clear suggestions after paste
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# Enable additional suggestion strategies
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
