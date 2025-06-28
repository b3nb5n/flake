# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
# https://vincent.bernat.ch/en/blog/2021-zsh-transient-prompt
# https://stackoverflow.com/questions/61075356/zle-reset-prompt-not-cleaning-the-prompt

setopt promptsubst

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

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats "%b%c%u %m"
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "*"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:git+set-message:*' hooks \
	git-is-worktree \
	git-ahead-behind

function +vi-git-is-worktree() {
	if [[ $(command git rev-parse --is-inside-work-tree 2>/dev/null) != 'true' ]]; then
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

_set_prompt() {
	local host_bg_color="#7aa2f7"
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		host_bg_color="#1abc9c"
	elif [[ "$USER" == "root" ]]; then
		host_bg_color="#9d7cd8"
	fi

	if (($_history_prompt)); then
		PROMPT="%F{$host_bg_color}%B~ ❱%f%b "
		return
	fi

	PROMPT="╭─"

	local os_icon=""
	if [[ $OSTYPE == darwin* ]]; then
		os_icon=""
	elif [[ $OSTYPE == "linux-gnu" && $NIX_PATH != "" ]]; then
		os_icon=""
	fi

	_add_prompt_segment "$os_icon" "#c0caf5"

	if (($_previous_exit_code)); then
		_add_prompt_segment "$_previous_exit_code" "#f7768e"
	fi

	_add_prompt_segment "%n@%m" $host_bg_color

	local status_content=""

	if [[ $SHLVL -gt 1 ]]; then
		status_content+=" $SHLVL"
	fi

	vcs_info
	if [ $vcs_info_msg_0_ ]; then
		if [[ -n $status_content ]]; then
			status_content+=" | "
		fi

		local content="$(echo "${vcs_info_msg_0_}" | sed "s/\(^ *\| *\$\)//g")"
		status_content+=" $content"
	fi

	if [[ -n $status_content ]]; then
		_add_prompt_segment "%F{$host_bg_color}$status_content%f" "#414868"
	fi

	_close_prompt_segment
	PROMPT+=" %F{#c0caf5}%~%f"

	local CR=$'\n'
	PROMPT+="$CR╰ %F{$host_bg_color}%B❱%f%b "
}

function zle-line-init {
	[[ $CONTEXT == start ]] || return 0

	# init vi keymap and cursor
	zle -K viins
	echo -ne '\e[5 q'

	# # Start regular line editor
	(( ${+zle_bracketed_paste} )) && print -r -n - $zle_bracketed_paste[1]
	zle .recursive-edit
	local -i ret=$?
	(( ${+zle_bracketed_paste} )) && print -r -n - $zle_bracketed_paste[2]

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

	if ((ret)); then
		# Ctrl-C
		zle .send-break
	else
		# Enter
		zle .accept-line
	fi

	return ret
}

precmd_functions+=(_preserve_exit_code)
precmd_functions+=(_set_prompt)

zle -N zle-line-init

