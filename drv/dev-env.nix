{ pkgs, usrDrv, ... }:
pkgs.buildEnv {
  name = "development-env";
  paths = with pkgs // usrDrv; [
    neovim
    nawk
    curl
    ripgrep
    locale
    git
    gh
    lazygit
    lazydocker
    lazysql
    wuzz
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" "rustfmt" ];
    })
    zig
  ];
}
