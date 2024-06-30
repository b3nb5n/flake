{ pkgs, repos, ... }: {
  imports = [
    ./git.nix
    ./zsh.nix
    ./direnv.nix
    ./neovim.nix
    ./fastfetch.nix
  ];

  home.packages = with pkgs // repos.usrDrv; [
    lf
    ttyper
    sic
    lazygit
    lazysql
    wuzz
  ];
}
