# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
# https://vincent.bernat.ch/en/blog/2021-zsh-transient-prompt
# https://stackoverflow.com/questions/61075356/zle-reset-prompt-not-cleaning-the-prompt

_previous_exit_code=0
_preserve_exit_code() {
	_previous_exit_code=$?	
}

_previous_segment_bg=""
_add_prompt_segment() {
	if [[ -z $_previous_segment_bg ]]; then
		PROMPT+="%F{$2}%f"
	else
		PROMPT+="%F{$_previous_segment_bg}%K{$2}%f%k"
	fi
	
	PROMPT+="%F{black}%K{$2} $1 %f%k"
	_previous_segment_bg=$2
}

_close_prompt_segment() {
	if [[ -z $_previous_segment_bg ]]; then
		return
	fi

	PROMPT+="%F{$_previous_segment_bg}%K{default}%f%k"
	_previous_segment_bg=""
}

_set_prompt() {
    if (( $_history_prompt )); then
		PROMPT="%F{blue}%B~ ❱ %f%b"
        return
	else
		PROMPT="╭─"
    fi

	if (( $_previous_exit_code )); then
		_add_prompt_segment "$_previous_exit_code" "red"
	fi

	local os_icon=""
	if [[ $OSTYPE == darwin* ]]; then
		os_icon=""
	elif [[ $OSTYPE == "linux-gnu" && $NIX_PATH != "" ]]; then
		os_icon=""
	fi
	
	_add_prompt_segment $os_icon "white"

	local host_bg_color="blue"
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		host_bg_color="yellow"
	fi

	_add_prompt_segment "󰖟 %n@%m" $host_bg_color

	if [[ $SHLVL -gt 1 ]]; then
		_add_prompt_segment " $SHLVL" "magenta"
	fi

	_add_prompt_segment " %~" "cyan"

	vcs_info
	if [ $vcs_info_msg_0_ ]; then
		local content="$(echo "${vcs_info_msg_0_}" | sed "s/\(^ *\| *\$\)//g")"
		_add_prompt_segment $content "green"
	fi

	_close_prompt_segment

	local CR=$'\n'
	PROMPT+="$CR╰ %F{blue}%B❱%f%b "
}

function zle-line-init {
    [[ $CONTEXT == start ]] || return 0

	# init vi keymap and cursor
	zle -K viins
	echo -ne '\e[5 q'

    # Start regular line editor
    (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[1]
    zle .recursive-edit
    local -i ret=$?
    (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[2]

    # If we received EOT, we exit the shell
    if [[ $ret == 0 && $KEYS == $'\4' ]]; then
        _history_prompt=1
        zle .reset-prompt
        exit
    fi

    # Line edition is over. Shorten the current prompt.
    _history_prompt=1
	local precmd
	for precmd in $precmd_functions; do
		$precmd
	done

    zle .reset-prompt
    unset _history_prompt

    if (( ret )); then
        # Ctrl-C
        zle .send-break
    else
        # Enter
        zle .accept-line
    fi

    return ret
}

function zle-keymap-select {
	if [[ ${KEYMAP} == 'vicmd' || $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[
		${KEYMAP} == 'main'
		|| ${KEYMAP} == 'viins'
		|| ${KEYMAP} == ''
		|| $1 = 'beam'
	]]; then
		echo -ne '\e[5 q'
	fi
}

setopt promptsubst
precmd_functions+=(_preserve_exit_code)
precmd_functions+=(_set_prompt)
zle -N zle-line-init
zle -N zle-keymap-select

bindkey -v # enable vi mode
export KEYTIMEOUT=1
echo -ne '\e[5 q' # beam shaped cursor

zstyle ':completion:*' menu select
zmodload zsh/complist

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git 
zstyle ':vcs_info:git:*' formats " %b%c%u %m"
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "*"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:git+set-message:*' hooks \
	git-is-worktree \
	git-ahead-behind

function +vi-git-is-worktree() {
	if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
		# hook functions after this will not be called if not 0 is returned.
		return 1
	fi

	return 0
}

function +vi-git-ahead-behind() {
	local behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)
	local ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)

	if [[ $behind -gt 0 ]]; then
		hook_com[misc]+="↓$behind"
	fi

	if [[ $ahead -gt 0 ]]; then
		hook_com[misc]+="↑$ahead"
	fi
}

