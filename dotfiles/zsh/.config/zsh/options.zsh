PROMPT_EOL_MARK='' # prevents printing '%' to indicate lack of EOL

unsetopt EXTENDED_GLOB # don't treat special characters as part of patterns
unsetopt BEEP # do not beep on errors
setopt INTERACTIVE_COMMENTS # allow use of comments in interactive code
setopt LONG_LIST_JOBS # list jobs in the long format by default
setopt AUTO_RESUME # attempt to resume existing job before creating a new process
setopt NOTIFY # report status of background jobs immediately
unsetopt RM_STAR_SILENT # notify when rm is running with *
setopt RM_STAR_WAIT # wait for 10 seconds confirmation when running rm with *

HISTSIZE="200" # max in memory zsh session history entries
SAVEHIST="6000" # max on disk zsh history entries
HISTFILE="$ZSH_STATE_DIR/.zhistory"

setopt EXTENDED_HISTORY # save each commands timestamp and duration to the history file
unsetopt SHARE_HISTORY # dont share history with other zsh sessions
setopt INC_APPEND_HISTORY # write to history immediately after a command is executed
setopt HIST_FCNTL_LOCK # better history file write locking
unsetopt HIST_SAVE_NO_DUPS # save complete history to disk
unsetopt HIST_IGNORE_ALL_DUPS # save complete history to disk
setopt HIST_EXPIRE_DUPS_FIRST # remove duplicates first when trimming history
setopt HIST_FIND_NO_DUPS # dont show duplicates in history search
setopt HIST_REDUCE_BLANKS # trim multiple insgnificant blanks in history
setopt HIST_IGNORE_SPACE  # don’t store lines starting with space

setopt AUTO_PARAM_SLASH # complete folders with / at end
setopt LIST_TYPES # mark type of completion suggestions
setopt COMPLETE_IN_WORD # allow completion from within a word/phrase
setopt ALWAYS_TO_END # move cursor to the end of a completed word
