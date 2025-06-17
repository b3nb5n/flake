HISTSIZE="8000"
SAVEHIST="8000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS # remove all earlier duplicate lines
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY      # import new commands from the history file also in other zsh-session
setopt EXTENDED_HISTORY   # save each commands beginning timestamp and the duration to the history file
setopt HIST_REDUCE_BLANKS # trim multiple insgnificant blanks in history
setopt HIST_IGNORE_SPACE  # don’t store lines starting with space

# source "$ZSH_PLUGIN_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh"
#
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
#
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down
