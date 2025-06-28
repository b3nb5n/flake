export ZDOTDIR=${ZDOTDIR:-$HOME}
export ZSH_CONFIG_DIR="$ZDOTDIR/.config/zsh"
export ZSH_PLUGIN_DIR="$ZSH_CONFIG_DIR/plugins"

source "$ZSH_CONFIG_DIR/options.zsh"
source "$ZSH_CONFIG_DIR/prompt.zsh"
source "$ZSH_CONFIG_DIR/highlighting.zsh"
source "$ZSH_CONFIG_DIR/history.zsh"
source "$ZSH_CONFIG_DIR/completion.zsh"
source "$ZSH_CONFIG_DIR/vi-mode.zsh"
source "$ZSH_CONFIG_DIR/direnv.zsh"
source "$ZSH_CONFIG_DIR/fastfetch.zsh"
