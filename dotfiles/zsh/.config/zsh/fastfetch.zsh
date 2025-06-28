local fastfetch="$(command -v fastfetch)"
if [[ -n $fastfetch ]] && [[ "$TERMINAL" == *"$TERM" ]]; then
	$fastfetch
fi
