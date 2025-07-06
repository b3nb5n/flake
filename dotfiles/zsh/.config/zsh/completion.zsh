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

zmodload zsh/complist
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste) # Clear suggestions after paste
ZSH_AUTOSUGGEST_STRATEGY=(history completion)    # Enable additional suggestion strategies

source "${ZSH_PLUGIN_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${ZSH_PLUGIN_DIR}/fzf-tab/fzf-tab.zsh"
