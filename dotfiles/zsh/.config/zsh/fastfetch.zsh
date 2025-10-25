[ -x "$(command -v fastfetch)" ] || return

if [[ "$TERMINAL" == *"$TERM" ]]; then
	fastfetch
	echo
fi
