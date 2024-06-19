{ pkgs, repos, ... }: {
  imports = [ ./git.nix ./zsh.nix ./direnv.nix ./neovim.nix ./neofetch.nix ];

  home.packages = with pkgs // repos.usrDrv; [
    lf
    ttyper
    sic
    lazygit
    lazysql
    wuzz
  ];
}
