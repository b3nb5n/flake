# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information

pill_segment() {
	echo "%F{$1}%K{$2} $3 %f%k%F{$2}%K{$4}%f%k"
}

set_prompt() {
	local exit_status=$?
	local exit_pill="%F{white}%f"
	if [[ $exit_status != 0 ]]; then
		exit_pill="%F{red}%f%F{black}%K{red} $exit_status %f$exit_pill%k"
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
	local git_pill
	local git_bg_color="default"
	if [ $vcs_info_msg_0_ ]; then
		git_bg_color="green"

		local content="$(echo "${vcs_info_msg_0_}" | sed "s/\(^ *\| *\$\)//g")"
		git_pill=$(pill_segment "black" $git_bg_color $content "default")
	fi

	local os_pill=$(pill_segment "black" "white" $os_icon $host_bg_color)
	local host_pill=$(pill_segment "black" $host_bg_color "󰖟 %n@%m" "cyan")
	local path_pill=$(pill_segment "black" "cyan" " %~" $git_bg_color)

	local upper_line="╭─$exit_pill$os_pill$host_pill$path_pill$git_pill"
	local lower_line="╰ %F{blue}%B❱%f%b "

	local CR=$'\n'
	PROMPT="$upper_line$CR$lower_line"
}

setopt promptsubst
precmd_functions+=("set_prompt")

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

