# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
# https://vincent.bernat.ch/en/blog/2021-zsh-transient-prompt
# https://stackoverflow.com/questions/61075356/zle-reset-prompt-not-cleaning-the-prompt

_prompt_segment() {
	echo "%F{$1}%K{$2} $3 %f%k%F{$2}%K{$4}%f%k"
}

_set_prompt() {
    if (( $_history_prompt )); then
		PROMPT="%F{blue}%B~ ❱ %f%b"
        return
    fi

	local -i exit_code=$?
	local exit_status="%F{white}%f"
	if (( $exit_code )); then
		exit_status="%F{red}%f%F{black}%K{red} $exit_code %f$exit_status%k"
	fi

	local os_type=$OSTYPE
	local os_icon=""
	if [[ $os_type == darwin* ]]; then
		os_icon=""
	elif [[ $os_type == "linux-gnu" && $NIX_PATH != "" ]]; then
		os_icon=""
	fi

	local host_bg_color="blue"
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		host_bg_color="yellow"
	fi

	vcs_info
	local git_status
	local git_bg_color="default"
	if [ $vcs_info_msg_0_ ]; then
		git_bg_color="green"

		local content="$(echo "${vcs_info_msg_0_}" | sed "s/\(^ *\| *\$\)//g")"
		git_status=$(_prompt_segment "black" $git_bg_color $content "default")
	fi

	local os_status=$(_prompt_segment "black" "white" $os_icon $host_bg_color)
	local host_status=$(_prompt_segment "black" $host_bg_color "󰖟 %n@%m" "cyan")
	local path_status=$(_prompt_segment "black" "cyan" " %~" $git_bg_color)

	local upper_line="╭─$exit_status$os_status$host_status$path_status$git_status"
	local lower_line="╰ %F{blue}%B❱%f%b "

	local CR=$'\n'
	PROMPT="$upper_line$CR$lower_line"
}

_draw_line_editor() {
    [[ $CONTEXT == start ]] || return 0

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

	# TODO: preserve exit code
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

setopt promptsubst
precmd_functions+=("_set_prompt")
zle -N zle-line-init _draw_line_editor

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

