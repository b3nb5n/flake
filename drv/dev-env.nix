{ pkgs, usrDrv, ... }:
pkgs.buildEnv {
  name = "development-env";
  paths = with pkgs // usrDrv; [
    neovim
    git
    lazygit
    lazydocker
    lazysql
    wuzz
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" "rustfmt" ];
    })
  ];
}
