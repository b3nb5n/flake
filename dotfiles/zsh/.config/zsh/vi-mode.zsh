function zle-keymap-select {
	if [[ ${KEYMAP} == 'vicmd' || $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ 
		${KEYMAP} == 'main' ||
		${KEYMAP} == 'viins' ||
		${KEYMAP} == '' ||
		$1 = 'beam' ]] \
		; then
		echo -ne '\e[5 q'
	fi
}

zle -N zle-keymap-select

bindkey -v        # enable vi mode
echo -ne '\e[5 q' # beam shaped cursor
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
