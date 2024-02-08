{ pkgs, usrDrv, ... }:
pkgs.buildEnv {
  name = "development-env";
  paths = with pkgs // usrDrv; [
    neovim
    git
    lazygit
    lazydocker
    lazysql
    slumber
  ];
}
