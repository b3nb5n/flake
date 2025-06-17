local direnv="$(command -v direnv)"
if [ -n $direnv ]; then
	eval "$($direnv hook zsh)"
fi
