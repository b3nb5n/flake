# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats "%b%c%u %m"
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "*"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:git+set-message:*' hooks git-ahead-behind

function +vi-git-ahead-behind() {
	local is_worktree=$(git rev-parse --is-inside-work-tree 2> /dev/null)
	if [[ $is_worktree != 'true' ]]; then
		return 0
	fi

	local behind=$(git rev-list --count HEAD..@{u} 2> /dev/null)
	local ahead=$(git rev-list --count @{u}..HEAD 2> /dev/null)

	if [[ $behind -gt 0 ]]; then
		hook_com[misc]+="↓$behind"
	fi

	if [[ $ahead -gt 0 ]]; then
		hook_com[misc]+="↑$ahead"
	fi
}

precmd_functions+=(vcs_info)
