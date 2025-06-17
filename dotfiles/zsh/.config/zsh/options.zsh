setopt EXTENDED_GLOB        # treat special characters as part of patterns
setopt CORRECT_ALL          # try to correct the spelling of all arguments in a line
setopt CLOBBER              # allow > redirection to truncate existing files
unsetopt BEEP               # do not beep on errors
unsetopt NOMATCH            # try to avoid the 'zsh: no matches found...'
setopt INTERACTIVE_COMMENTS # allow use of comments in interactive code
setopt LONG_LIST_JOBS       # list jobs in the long format by default
setopt AUTO_RESUME          # attempt to resume existing job before creating a new process
setopt NOTIFY               # report status of background jobs immediately
unsetopt SHORT_LOOPS        # disable short loop forms, can be confusing
unsetopt RM_STAR_SILENT     # notify when rm is running with *
setopt RM_STAR_WAIT         # wait for 10 seconds confirmation when running rm with *
