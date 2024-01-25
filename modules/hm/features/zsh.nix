{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      pre-switch = ''cd ~/.flake && nix flake lock && git add . && git commit -m "$(date)"'';
      post-switch = ''cd -'';
      switch-sys = ''pre-switch && sudo nixos-rebuild switch --flake ~/.flake && post-switch'';
      switch-home = ''pre-switch && home-manager switch --flake ~/.flake && post-switch'';
    };
  };
}