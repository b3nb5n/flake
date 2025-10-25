ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste) # Clear suggestions after paste
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

source "${ZSH_PLUGIN_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"
