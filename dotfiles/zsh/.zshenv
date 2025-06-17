local term_path="$(command -v $TERM)"
local alacritty_path="$(command -v alacritty)"
if [ -n $term_path ]; then
	export TERMINAL=${term_path:-$alacritty_path}
fi

local browser_path="$(command -v firefox)"
if [ -n $browser_path ]; then
	export BROWSER=$browser_path
fi

local editor_path="$(command -v nvim)"
if [ -n $editor_path ]; then
	export EDITOR=$editor_path
	export VISUAL=$editor_path
fi
