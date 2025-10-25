# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

local L_CAP=""
local R_CAP=""
local SEPARATOR=" | "

local COLOR_ACCENT="#7aa2f7"
if [[ "$USER" == "root" ]]; then
	COLOR_ACCENT="#9d7cd8"
elif [ -n "$SSH_CLIENT" ]; then
	COLOR_ACCENT="#1abc9c"
fi

local COLOR_FG="#c0caf5"
local COLOR_BG="#414868"
local COLOR_ERROR="#f7768e"

function _prompt_get_linux_os_icon() {
	local default_icon=''

	local grep="$(command -v grep)"
	if [[ ! -f /etc/os-release ]] || [[	-z "$grep" ]]; then
		echo "$default_icon"
		return
	fi

	local os_id=$(grep '^ID=' /etc/os-release)
	case "$os_id" in
		*nixos) echo '' ;;
		*) echo "$default_icon" ;;
	esac
}

local os_icon=''
function _prompt_get_os_icon() {
	if [[ -n "$os_icon" ]]; then
		echo "$os_icon"
		return
	fi

  case "$OSTYPE" in
		linux*) os_icon="$(_prompt_get_linux_os_icon)" ;;
		darwin*) os_icon='' ;;
    *) os_icon='' ;;
  esac

	echo "$os_icon"
}

function _prompt_get_shell_level() {
	[[ $SHLVL -gt 1 ]] || return 
	echo " $SHLVL"
}

function _prompt_get_vcs_info() {
	[[ -n "$vcs_info_msg_0_" ]] || return
	echo " $vcs_info_msg_0_"
}

function _prompt_get_status_info() {
	local info_fns=(_prompt_get_shell_level _prompt_get_vcs_info)
	local status_info=""

	for fn in "${info_fns[@]}"; do
		local info="$("$fn")"
		info="$(echo $info | xargs)"

		[[ -z $info ]] && continue
		if [[ -n "$status_info" ]]; then
			status_info+="$SEPARATOR"
		fi

		status_info+="$info"
	done

	echo "$status_info"
}

local first_prompt=true
function _prompt_unset_first() {
	first_prompt=false
}

local exit_code="0"
function _prompt_preserve_exit_code() {
	exit_code="$?"
}

function _set_prompt() {
	local prev_segment_bg

	close_segment() {
		local background="${1:-default}"

		PROMPT+="%F{$prev_segment_bg}%K{$background}$R_CAP%f%k"
		prev_segment_bg=''
	}

	add_segment() {
		local content="$1"
		local background="$2"
		local foreground="$3"

		if [[ -z $prev_segment_bg ]]; then
			PROMPT+="%F{$background}$L_CAP%f"
		else
			close_segment "$background"
		fi

		PROMPT+="%K{$background}%F{$foreground} $content %k%f"
		prev_segment_bg=$background
	}

	PROMPT=""
	local CR=$'\n'

	if [[ "$first_prompt" == "false" ]]; then PROMPT+="$CR"; fi
	PROMPT+="%F{$COLOR_FG}╭─%f"

	add_segment "$(_prompt_get_os_icon)" "$COLOR_FG" "$COLOR_BG"
	add_segment "$USER@$HOST" "$COLOR_ACCENT" "$COLOR_BG"

	local status_info="$(_prompt_get_status_info)"
	if [[ -n $status_info ]]; then
		add_segment "$status_info" "$COLOR_BG" "$COLOR_ACCENT"
	fi

	if [[ "$exit_code" -ne "0" ]]; then
		add_segment "$exit_code" "$COLOR_ERROR" "$COLOR_BG"
	fi

	close_segment

	PROMPT+="%F{$COLOR_FG} %~%f$CR"
	PROMPT+="%F{$COLOR_FG}╰%f %F{$COLOR_ACCENT}%B❱%f%b "
	TRANSIENT_PROMPT_PROMPT=$PROMPT
}

precmd_functions+=(_prompt_preserve_exit_code)
precmd_functions+=(_set_prompt)

_set_prompt

TRANSIENT_PROMPT_TRANSIENT_PROMPT="%F{$COLOR_ACCENT}~ ❱%f "
function TRANSIENT_PROMPT_PRETRANSIENT() {
	_prompt_unset_first
}

source "$ZSH_PLUGIN_DIR/zsh-transient-prompt/transient-prompt.zsh-theme"
