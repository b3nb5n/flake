{ pkgs, ... }: {
  imports = [ ./git.nix ./zsh.nix ./direnv.nix ./neovim.nix ./fastfetch.nix ];

  home.packages = with pkgs; [
    lf
    lsof
    ttyper
    lazygit
    lazysql
    wuzz
    vitetris
    gotop
  ];
}
