local firefox="$(command -v firefox)" 
if [[ -x "$firefox" ]]; then
	export BROWSER="$firefox"
fi

local floorp="$(command -v floorp)"
if [[ -x "$floorp" ]]; then
	export BROWSER="$floorp"
fi

local alacritty="$(command -v alacritty)"
if [[ -x "$alacritty" ]]; then
	export TERMINAL="$alacritty"
fi

local neovim="$(command -v nvim)"
if [[ -x "$neovim" ]]; then
	export EDITOR="$neovim"
	export VISUAL="$neovim"

	alias vi="$neovim"
	alias vim="$neovim"
fi
