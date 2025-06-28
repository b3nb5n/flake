bindkey -v
export KEYTIMEOUT=1

local beam='\e[5 q'
local block='\e[2 q'

function zle-keymap-select {
	if [[ ${KEYMAP} == 'vicmd' || $1 = 'block' ]]; then
		echo -ne $block
	elif [[ ${KEYMAP} == 'main' || ${KEYMAP} == 'viins' || ${KEYMAP} == '' || $1 = 'beam' ]]; then
		echo -ne $beam
	fi
}

_reset_cursor() {
	echo -ne $beam
}

zle -N zle-keymap-select
precmd_functions+=(_reset_cursor)

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
