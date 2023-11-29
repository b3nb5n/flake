{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      switch-sys = "sudo nixos-rebuild switch --flake ~/.flake";
      switch-home = "home-manager switch --flake ~/.flake";
    };
  };
}